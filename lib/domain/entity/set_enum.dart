enum SetEnum {
  Core,
  Awesome,
  Cthulhu,
  Science,
  Geeky,
  Pretty,
  Munchkin,
  Fault,
  CeaseAndDesist,
  Thinking,
  AllStarts,
  Sheep,
  Geekier,
  DidItAgain,
  International,
  Penguins,
  CultureShock,
  Marvel,
  Goblins,
  KnightsOfTheRoundTable,
  Disney,
  Anniversary,
  Unknown,
  MonsterSmash,
  Japan,
  Expansion70;

  static SetEnum fromString(String string) {
    switch (string) {
      case "Core Set":
        return SetEnum.Core;
      case "Awesome Level 9000":
        return SetEnum.Awesome;
      case "The Obligatory Cthulhu Set":
        return SetEnum.Cthulhu;
      case "Science Fiction Double Feature":
        return SetEnum.Science;
      case "The Big Geeky Box":
        return SetEnum.Geeky;
      case "Monster Smash":
        return SetEnum.MonsterSmash;
      case "Pretty Pretty Smash Up":
        return SetEnum.Pretty;
      case "Smash Up: Munchkin":
        return SetEnum.Munchkin;
      case "It’s Your Fault!":
        return SetEnum.Fault;
      case "Cease and Desist":
        return SetEnum.CeaseAndDesist;
      case "What Were We Thinking?":
        return SetEnum.Thinking;
      case "All Stars Event Kit":
        return SetEnum.AllStarts;
      case "Big in Japan":
        return SetEnum.Japan;
      case "Smash Up Sheep Promo":
        return SetEnum.Sheep;
      case "That ’70s Expansion":
        return SetEnum.Expansion70;
      case "The Bigger Geekier Box":
        return SetEnum.Geekier;
      case "Oops, You Did It Again":
        return SetEnum.DidItAgain;
      case "World Tour: International Incident":
        return SetEnum.International;
      case "Smash Up Penguins":
        return SetEnum.Penguins;
      case "World Tour: Culture Shock":
        return SetEnum.CultureShock;
      case "Smash Up: Marvel":
        return SetEnum.Marvel;
      case "Smash Up Goblins":
        return SetEnum.Goblins;
      case "Smash Up Knights of the Round Table":
        return SetEnum.KnightsOfTheRoundTable;
      case "Smash Up: Disney Edition":
        return SetEnum.Disney;
      case "10th Anniversary":
        return SetEnum.Anniversary;
      default:
        return SetEnum.Unknown;
    }
  }
}
