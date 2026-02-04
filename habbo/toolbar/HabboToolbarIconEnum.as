package com.sulake.habbo.toolbar
{
   import flash.utils.Dictionary;
   
   [SecureSWF(rename="false")]
   public class HabboToolbarIconEnum
   {
      
      public static const HELP:String = "HTIE_ICON_HELP";
      
      public static const NAVIGATOR:String = "HTIE_ICON_NAVIGATOR";
      
      public static const CATALOGUE:String = "HTIE_ICON_CATALOGUE";
      
      public static const INVENTORY:String = "HTIE_ICON_INVENTORY";
      
      public static const PROGRESSION:String = "HTIE_ICON_PROGRESSION";
      
      public static const ACHIEVEMENTS:String = "HTIE_ICON_ACHIEVEMENTS";
      
      public static const MEMENU:String = "HTIE_ICON_MEMENU";
      
      public static const GAMES:String = "HTIE_ICON_GAMES";
      
      public static const STORIES:String = "HTIE_ICON_STORIES";
      
      public static const RECEPTION:String = "HTIE_ICON_RECEPTION";
      
      public static const HOME:String = "HTIE_ICON_HOME";
      
      public static const GUIDE:String = "HTIE_ICON_GUIDE";
      
      public static const BUILDER:String = "HTIE_ICON_BUILDER";
      
      public static const CAMERA:String = "HTIE_ICON_CAMERA";
      
      public static const WIRED_MENU:String = "HTIE_ICON_WIRED_MENU";
      
      public static const ROOMINFO:String = "HTIE_ICON_ROOMINFO";
      
      public static const const_882:String = "HTIE_EXT_GROUP";
      
      public static const NAVIGATOR_ME_TAB:String = "HTIE_ICON_NAVIGATOR_ME_TAB";
      
      private static const _TOOLBAR_NAMES:Dictionary = new Dictionary();
      
      _TOOLBAR_NAMES["HTIE_ICON_HELP"] = "HELP";
      _TOOLBAR_NAMES["HTIE_ICON_NAVIGATOR"] = "NAVIGATOR";
      _TOOLBAR_NAMES["HTIE_ICON_CATALOGUE"] = "CATALOGUE";
      _TOOLBAR_NAMES["HTIE_ICON_INVENTORY"] = "INVENTORY";
      _TOOLBAR_NAMES["HTIE_ICON_PROGRESSION"] = "PROGRESSION";
      _TOOLBAR_NAMES["HTIE_ICON_ACHIEVEMENTS"] = "ACHIEVEMENTS";
      _TOOLBAR_NAMES["HTIE_ICON_MEMENU"] = "MEMENU";
      _TOOLBAR_NAMES["HTIE_ICON_GAMES"] = "GAMES";
      _TOOLBAR_NAMES["HTIE_ICON_STORIES"] = "STORIES";
      _TOOLBAR_NAMES["HTIE_ICON_RECEPTION"] = "RECEPTION";
      _TOOLBAR_NAMES["HTIE_ICON_HOME"] = "HOME";
      _TOOLBAR_NAMES["HTIE_ICON_GUIDE"] = "GUIDE";
      _TOOLBAR_NAMES["HTIE_ICON_BUILDER"] = "BUILDER";
      _TOOLBAR_NAMES["HTIE_ICON_CAMERA"] = "CAMERA";
      _TOOLBAR_NAMES["HTIE_ICON_WIRED_MENU"] = "WIRED_MENU";
      
      public function HabboToolbarIconEnum()
      {
         super();
      }
      
      public static function getIconName(param1:String) : String
      {
         return _TOOLBAR_NAMES[param1];
      }
   }
}

