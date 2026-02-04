package com.sulake.habbo.localization
{
   import com.sulake.core.localization.class_26;
   import com.sulake.core.runtime.IUnknown;
   import com.sulake.core.utils.class_55;
   
   public interface class_27 extends class_26, IUnknown
   {
      
      function loadDefaultEmbedLocalizations(param1:String, param2:Boolean = false) : Boolean;
      
      function requestLocalizationInit() : void;
      
      function getActiveEnvironmentId() : String;
      
      function getExternalVariablesUrl() : String;
      
      function getExternalVariablesHash() : String;
      
      function getLocalizationWithParams(param1:String, param2:String = "", ... rest) : String;
      
      function getLocalizationWithParamMap(param1:String, param2:String = "", param3:class_55 = null) : String;
      
      function getAchievementName(param1:String) : String;
      
      function getAchievementDesc(param1:String, param2:int) : String;
      
      function getAchievementInstruction(param1:String) : String;
      
      function getBadgeBaseName(param1:String) : String;
      
      function getBadgeName(param1:String) : String;
      
      function getBadgeDesc(param1:String) : String;
      
      function setBadgePointLimit(param1:String, param2:int) : void;
      
      function getPreviousLevelBadgeId(param1:String) : String;
   }
}

