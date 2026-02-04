package com.sulake.habbo.help.enum
{
   import flash.events.Event;
   
   public class HabboHelpTutorialEvent extends Event
   {
      
      public static const const_96:String = "HHTPNUFWE_AVATAR_TUTORIAL_START";
      
      public static const const_1170:String = "HHTPNUFWE_LIGHT_CLOTHES_ICON";
      
      public static const DONE_AVATAR_EDITOR_OPENING:String = "HHTE_DONE_AVATAR_EDITOR_OPENING";
      
      public static const DONE_AVATAR_EDITOR_CLOSING:String = "HHTE_DONE_AVATAR_EDITOR_CLOSING";
      
      public function HabboHelpTutorialEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}

