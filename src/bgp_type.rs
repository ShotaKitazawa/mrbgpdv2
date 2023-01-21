#[derive(PartialEq, Eq, Debug, Clone, Copy, Hash, PartialOrd, Ord)]
pub struct AutonomousSystemNumber(u16);
impl From<AutonomousSystemNumber> for u16 {
    fn from(as_number: AutonomousSystemNumber) -> u16 {
        as_number.0
    }
}

impl From<u16> for AutonomousSystemNumber {
    fn from(as_number: u16) -> Self {
        Self(as_number)
    }
}
