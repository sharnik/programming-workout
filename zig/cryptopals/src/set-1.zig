const std = @import("std");
const Zigstr = @import("zigstr");

pub fn loadHex(str: []const u8, output: []u8) void {
    var n: u32 = 0;

    while (n < str.len / 2) : (n += 1) {
        output[n] = std.fmt.parseUnsigned(u8, str[2 * n .. 2 * n + 2], 16) catch 'X';
    }
}

test "loading hex strings" {
    const inputHex: []const u8 = "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d";

    var parsedString = try std.testing.allocator.alloc(u8, inputHex.len / 2);
    defer std.testing.allocator.free(parsedString);

    loadHex(inputHex, parsedString);

    try std.testing.expectEqualStrings("I'm killing your brain like a poisonous mushroom", parsedString);
}

test "encoding as Base64" {
    const inputString = "I'm killing your brain like a poisonous mushroom";

    const allocator = std.testing.allocator;
    const Encoder = std.base64.standard.Encoder;
    const encoded_length = Encoder.calcSize(inputString.len);
    const encodedString = try allocator.alloc(u8, encoded_length);
    defer allocator.free(encodedString);

    _ = Encoder.encode(encodedString, inputString);

    try std.testing.expectEqualStrings("SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t", encodedString);
}

pub fn xorStrings(input: []const u8, key: []const u8, output: []u8) void {
    if ((input.len != key.len) or (key.len != output.len)) return;

    var n: usize = 0;
    while (n < input.len) : (n += 1) output[n] = input[n] ^ key[n];
}

pub fn countChar(text: []const u8, char: u8, checkUpcase: bool) u8 {
    var count: u8 = 0;
    var index: usize = 0;
    while (index < text.len) : (index += 1) {
        if (text[index] == char or (checkUpcase and text[index] == char - 32)) count += 1;
    }

    return count;
}

// Returns a probability text is real
// Lower the better, it shows how far is the string from typical letter frequencies
pub fn scoreText(text: []const u8) u8 {
    var score: f16 = 0;

    // // We lower case the string to only care about a-z
    // const lowerCase = std.ascii.allocLowerString(std.testing.allocator, text) catch return 255;
    // std.testing.allocator.free(lowerCase);

    const charAsciiOffset: u8 = 97;
    const expectedFrequency = [_]f16{ 8.167, 1.492, 2.782, 4.253, 12.702, 2.228, 2.015, 6.094, 6.966, 0.153, 0.772, 4.025, 2.406, 6.749, 7.507, 1.929, 0.095, 5.987, 6.327, 9.056, 2.758, 0.978, 2.360, 0.150, 1.974, 0.074, 13.0, 8.5 };

    var currentChar: u8 = 0;
    while (currentChar <= 25) : (currentChar += 1) {
        const actualFrequency: f16 = @as(f16, @floatFromInt(countChar(text, currentChar + charAsciiOffset, true))) * 100.0 / @as(f16, @floatFromInt(text.len));
        score += @fabs(actualFrequency - expectedFrequency[currentChar]);
    }

    // Space frequency
    const actualFrequency: f16 = @as(f16, @floatFromInt(countChar(text, ' ', false))) * 100.0 / @as(f16, @floatFromInt(text.len));
    score += @fabs(actualFrequency - expectedFrequency[26]);

    return @intFromFloat(score);
}

test "scoring gibberish" {
    const gibberish1 = "Ammikle\"OA%q\"nkig\"c\"rmwlf\"md\"`caml";
    try std.testing.expectEqual(scoreText(gibberish1), 98);

    const gibberish2 = "Ieeacdm*GI-y*fcao*k*zedn*el*hkied";
    try std.testing.expectEqual(scoreText(gibberish2), 83);

    const wordsOfWisdom = "Cooking MC's like a pound of bacon";
    try std.testing.expectEqual(scoreText(wordsOfWisdom), 75);
}

const DecryptCandidate = struct { key: u8, score: u8, decrypted: []u8 };

pub fn findSingleCharKey(encrypted: []const u8, candidate: *DecryptCandidate) void {
    var key: u8 = 0;
    var index: usize = 0;
    var score: u8 = 0;
    const LAST_KEY_INDEX = 127;

    var decrypted = std.testing.allocator.alloc(u8, encrypted.len) catch unreachable;
    defer std.testing.allocator.free(decrypted);

    while (key < LAST_KEY_INDEX) : (key += 1) {
        index = 0;
        while (index < encrypted.len) : (index += 1) {
            decrypted[index] = encrypted[index] ^ key;
        }
        score = scoreText(decrypted[0..]);

        if (score < candidate.score) {
            candidate.key = key;
            candidate.score = score;

            std.mem.copy(comptime u8, candidate.decrypted, decrypted);
        }
    }
}

test "finding a single character key" {
    const encryptedHex = "1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736";
    var encrypted = try std.testing.allocator.alloc(u8, encryptedHex.len / 2);
    defer std.testing.allocator.free(encrypted);
    loadHex(encryptedHex, encrypted);

    var candidateDecrypted = std.testing.allocator.alloc(u8, encrypted.len) catch unreachable;
    defer std.testing.allocator.free(candidateDecrypted);
    var candidate = DecryptCandidate{ .key = 0, .score = 255, .decrypted = candidateDecrypted };

    _ = findSingleCharKey(encrypted, &candidate);
    // std.debug.print(("decrypted best string: {s}\n"), .{candidate.decrypted});
    try std.testing.expectEqual(candidate.key, 'X');
}

test "XOR encryption" {
    const encryptedHex = "1c0111001f010100061a024b53535009181c";
    var encrypted = try std.testing.allocator.alloc(u8, encryptedHex.len / 2);
    defer std.testing.allocator.free(encrypted);
    loadHex(encryptedHex, encrypted);

    const keyHex = "686974207468652062756c6c277320657965";
    var key = try std.testing.allocator.alloc(u8, keyHex.len / 2);
    defer std.testing.allocator.free(key);
    loadHex(keyHex, key);

    var decrypted = try std.testing.allocator.alloc(u8, encryptedHex.len / 2);
    defer std.testing.allocator.free(decrypted);
    xorStrings(encrypted, key, decrypted);

    try std.testing.expectEqualStrings("the kid don't play", decrypted);
    // std.debug.print("Decrypted: {s}.\n", .{decrypted});
}

test "Set 1, problem 4: finding encrypted text in a file" {
    var file = try std.fs.cwd().openFile("src/assets/set-1-problem-4.txt", .{});
    defer file.close();

    const contents = try file.reader().readAllAlloc(
        std.testing.allocator,
        100000,
    );
    defer std.testing.allocator.free(contents);

    var candidateDecrypted = std.testing.allocator.alloc(u8, 30) catch unreachable;
    defer std.testing.allocator.free(candidateDecrypted);
    var candidate = DecryptCandidate{ .key = 0, .score = 255, .decrypted = candidateDecrypted };

    var encryptedInput = try std.testing.allocator.alloc(u8, 30);
    defer std.testing.allocator.free(encryptedInput);

    var lines = std.mem.split(u8, contents, "\n");
    while (lines.next()) |line| {
        _ = loadHex(line, encryptedInput);
        _ = findSingleCharKey(encryptedInput, &candidate);

        if (candidate.score < 55) std.debug.print("Found key: {d} that decrypts: {s}\n", .{ candidate.key, candidate.decrypted });
        // candidate.score = 255;
    }
    try std.testing.expectEqualStrings("Now that the party is jumping\n", candidate.decrypted);
}

// AUTO GENERATED

pub fn main() !void {
    // Prints to stderr (it's a shortcut based on `std.io.getStdErr()`)
    std.debug.print("All MINE {s} are belong to us.\n", .{"codebase"});

    // stdout is for the actual output of your application, for example if you
    // are implementing gzip, then only the compressed bytes should be sent to
    // stdout, not any debugging messages.
    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();

    try stdout.print("Run `zig build test` to run the tests.\n", .{});

    try bw.flush(); // don't forget to flush!
}
