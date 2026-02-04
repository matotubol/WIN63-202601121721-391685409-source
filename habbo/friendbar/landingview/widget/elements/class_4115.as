package com.sulake.habbo.friendbar.landingview.widget.elements
{
   import com.sulake.habbo.friendbar.landingview.interfaces.elements.IElementHandler;
   
   public class class_4115
   {
      
      public static const CAPTION:String = "caption";
      
      public static const TITLE:String = "title";
      
      public static const const_1111:String = "subcaption";
      
      public static const BODYTEXT:String = "bodytext";
      
      public static const SPACING:String = "spacing";
      
      public static const CATALOGBUTTON:String = "catalogbutton";
      
      public static const PROMOTEDROOMBUTTON:String = "promotedroombutton";
      
      public static const LINK:String = "link";
      
      public static const const_684:String = "gotoroombutton";
      
      public static const REQUESTBADGEBUTTON:String = "requestbadgebutton";
      
      public static const REQUESTBADGEBUTTONSECOND:String = "requestbadgebuttonsecond";
      
      public static const REQUESTBADGEBUTTONTHIRD:String = "requestbadgebuttonthird";
      
      public static const REQUESTBADGEBUTTONFOURTH:String = "requestbadgebuttonfourth";
      
      public static const REQUESTBADGEBUTTONFIFTH:String = "requestbadgebuttonfifth";
      
      public static const CREDITHABBLETBUTTON:String = "credithabbletbutton";
      
      public static const COMMUNITYGOALTIMER:String = "communitygoaltimer";
      
      public static const CUSTOMTIMER:String = "customtimer";
      
      public static const const_709:String = "gotohomeroombutton";
      
      public static const const_1176:String = "gotocompetitionroombutton";
      
      public static const REWARDBADGE:String = "rewardbadge";
      
      public static const IMAGE:String = "image";
      
      public static const SUBMITCOMPETITIONROOM:String = "submitcompetitionroom";
      
      public static const CONCURRENTUSERSMETER:String = "concurrentusersmeter";
      
      public static const CONCURRENTUSERSINFO:String = "concurrentusersinfo";
      
      public static const DAILYQUEST:String = "dailyquest";
      
      public static const const_701:String = "buyvipbutton";
      
      public static const COMMUNITYGOALSCORE:String = "communitygoalscore";
      
      public static const INTERNAL_LINK_BUTTON:String = "internallinkbutton";
      
      public function class_4115()
      {
         super();
      }
      
      public static function createHandler(param1:String) : IElementHandler
      {
         switch(param1)
         {
            case "caption":
            case "subcaption":
            case "bodytext":
               return new class_4133();
            case "title":
               return new TitleElementHandler();
            case "spacing":
               return new class_4138();
            case "catalogbutton":
               return new CatalogButtonElementHandler();
            case "promotedroombutton":
               return new class_4149();
            case "link":
               return new class_4141();
            case "gotoroombutton":
               return new class_4148();
            case "requestbadgebutton":
            case "requestbadgebuttonsecond":
            case "requestbadgebuttonthird":
            case "requestbadgebuttonfourth":
            case "requestbadgebuttonfifth":
               return new class_4144();
            case "credithabbletbutton":
               return new class_4136();
            case "communitygoaltimer":
               return new class_4145();
            case "customtimer":
               return new class_4143();
            case "gotohomeroombutton":
               return new class_4137();
            case "gotocompetitionroombutton":
               return new class_4146();
            case "rewardbadge":
               return new class_4134();
            case "image":
               return new class_4152();
            case "submitcompetitionroom":
               return new class_4150();
            case "concurrentusersmeter":
               return new class_4153();
            case "concurrentusersinfo":
               return new ConcurrentUsersInfoElementHandler();
            case "dailyquest":
               return new class_4147();
            case "buyvipbutton":
               return new class_4151();
            case "communitygoalscore":
               return new class_4139();
            case "internallinkbutton":
               return new class_4140();
            default:
               return null;
         }
      }
   }
}

