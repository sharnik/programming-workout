trait Monster {
    fn attack(&self);
}

struct OrcBerzerker {
    strength: int
}

impl Monster for OrcBerzerker {
    fn attack(&self) {
        println!("The Orc berserker slashes his axe at your head for {:d}.", self.strength)
    }
}

struct SkavenPlagueMonk {
    strength: int
}

impl Monster for SkavenPlagueMonk {
    fn attack(&self) {
        println!("The Skaven plague monk stabs you with a poisoned dagger for {:d}.", self.strength)
    }
}

fn monster_attack(monsters: &[&Monster]) {
    for monster in monsters.iter() {
        monster.attack();
    }
}

struct GoblinFanatic {
    strength: int
}

impl Monster for GoblinFanatic {
    fn attack(&self) {
        println!("Goblin fanatic hits you with a huge metal ball for {:d}.", self.strength);
    }
}

fn main() {
    let monster_vector: &[&Monster] = [
        &(OrcBerzerker {strength: 25}) as &Monster,
        &(SkavenPlagueMonk {strength: 10}) as &Monster,
        &(GoblinFanatic {strength: 35}) as &Monster,
    ];
    monster_attack(monster_vector);
}