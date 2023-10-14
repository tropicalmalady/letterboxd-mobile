String Function(String image) getDir(String dir) =>
    (String image) => "assets/images/$dir/$image";
String getRootDir(String image) => "assets/images/$image";

typedef ImageCallback = String Function(String image);

ImageCallback movieBannerDir = getDir("movies");
ImageCallback tourDir = getDir("tour");
ImageCallback postersDir=getDir("posters");

class MovieBannerImageManger {
  static String apocalypseNow = movieBannerDir("apocalypse_now.jpg");
  static String burning = movieBannerDir("burning.jpg");
  static String irmaVep = movieBannerDir("irma_vep.jpg");
  static String killerOfSheep = movieBannerDir("killer_of_sheep.png");
  static String persona = movieBannerDir("persona.jpeg");
  static String roma = movieBannerDir("roma.jpeg");
  static String swordOfDoom = movieBannerDir("sword_of_doom.jpg");
  static String theAdventure = movieBannerDir("the_adventure.jpeg");
  static String theGirlWithTheDragonTattoo = movieBannerDir("the_girl_with_the_dragon_tattoo.jpg");
  static String theTenant = movieBannerDir("the_tenant.webp");
  static String theVanishing = movieBannerDir("the_vanishing.jpeg");
  static String tropicalMalady = movieBannerDir("tropical_malady.jpg");
  static String wagesOfFear = movieBannerDir("wages_of_fear.jpg");
}

class ImageManager {
  static String logoDots = getRootDir("logoDots.png");
  static String letterboxdLogo=getRootDir("logo.png");
}

class TourImageManager {
  static String review = tourDir("review.png");
  static String diary = tourDir("diary.png");
  static String list = tourDir("list.png");
  static String log = tourDir("log.png");
  static String activity = tourDir("activity.png");
}

class PosterImageManager{
  static String birdMan=postersDir("poster1.jpeg");
}