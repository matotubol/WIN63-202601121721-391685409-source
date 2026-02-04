package com.sulake.habbo.localization
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.class_23;
   import com.sulake.core.localization.CoreLocalizationManager;
   import com.sulake.core.runtime.class_15;
   import com.sulake.core.utils.class_55;
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   public class HabboLocalizationManager extends CoreLocalizationManager implements class_27
   {
      
      private var var_1816:Boolean;
      
      private var _skipExternals:Boolean = false;
      
      private var var_3493:Dictionary = new Dictionary();
      
      private var _romanNumerals:Array = ["I","II","III","IV","V","VI","VII","VIII","IX","X","XI","XII","XIII","XIV","XV","XVI","XVII","XVIII","XIX","XX","XXI","XXII","XXIII","XXIV","XXV","XXVI","XXVII","XXVIII","XXIX","XXX"];
      
      public function HabboLocalizationManager(param1:class_15, param2:uint = 0, param3:class_40 = null)
      {
         _skipExternals = (param2 & 0x10000000) > 0;
         super(param1,param2,param3);
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
      
      override protected function initComponent() : void
      {
         super.initComponent();
         configureLocalizationLocations();
         if(_skipExternals)
         {
            events.dispatchEvent(new Event("complete"));
         }
         else
         {
            context.events.addEventListener("HABBO_CONNECTION_EVENT_AUTHENTICATED",onAuthenticated);
         }
      }
      
      private function onAuthenticated(param1:Event) : void
      {
         requestLocalizationInit();
      }
      
      public function loadDefaultEmbedLocalizations(param1:String, param2:Boolean = true) : Boolean
      {
         var _loc4_:String = "default_localizations_" + param1;
         var _loc5_:IAsset = assets.getAssetByName(_loc4_);
         if(!_loc5_ && param1 != "en" && param2)
         {
            class_21.log("Could not load default localizations " + _loc4_ + " : Trying with default_localizations_en...");
            return loadDefaultEmbedLocalizations("en",false);
         }
         var _loc3_:IAsset = assets.getAssetByName("default_localizations");
         parseLocalizationData(_loc3_.content as String);
         if(_loc5_)
         {
            parseLocalizationData(_loc5_.content as String);
            return true;
         }
         class_21.log("Could not load " + _loc4_);
         return false;
      }
      
      public function getLocalizationWithParams(param1:String, param2:String = "", ... rest) : String
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(rest != null && rest.length > 0)
         {
            _loc4_ = rest.length / 2;
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               registerParameter(param1,rest[_loc5_ * 2],rest[_loc5_ * 2 + 1]);
               _loc5_++;
            }
         }
         return this.getLocalization(param1,param2);
      }
      
      public function getLocalizationWithParamMap(param1:String, param2:String = "", param3:class_55 = null) : String
      {
         if(param3 != null)
         {
            for(var _loc4_ in param3)
            {
               registerParameter(param1,_loc4_,param3.getValue(_loc4_));
            }
         }
         return this.getLocalization(param1,param2);
      }
      
      public function getExternalVariablesUrl() : String
      {
         return super.getGameDataResources().getExternalVariablesUrl();
      }
      
      public function getExternalVariablesHash() : String
      {
         return super.getGameDataResources().getExternalVariablesHash();
      }
      
      override public function getActiveEnvironmentId() : String
      {
         return super.getActiveEnvironmentId();
      }
      
      override public function getLocalization(param1:String, param2:String = "") : String
      {
         var _loc3_:String = super.getLocalization(param1,param2);
         return interpolate(_loc3_);
      }
      
      public function getAchievementName(param1:String) : String
      {
         var _loc2_:BadgeBaseAndLevel = new BadgeBaseAndLevel(param1);
         var _loc4_:String = getExistingKey(["badge_name_al_" + param1,"badge_name_al_" + _loc2_.base,"badge_name_" + param1,"badge_name_" + _loc2_.base]);
         this.registerParameter(_loc4_,"roman",getRomanNumeral(_loc2_.level));
         var _loc3_:String = this.getLocalization(_loc4_);
         return _loc3_ ?? "";
      }
      
      public function getAchievementDesc(param1:String, param2:int) : String
      {
         var _loc3_:BadgeBaseAndLevel = new BadgeBaseAndLevel(param1);
         var _loc4_:String = getExistingKey(["badge_desc_al_" + param1,"badge_desc_al_" + _loc3_.base,"badge_desc_" + param1,"badge_desc_" + _loc3_.base]);
         this.registerParameter(_loc4_,"limit","" + param2);
         this.registerParameter(_loc4_,"roman",getRomanNumeral(_loc3_.level));
         return this.getLocalization(_loc4_);
      }
      
      public function getAchievementInstruction(param1:String) : String
      {
         var _loc2_:BadgeBaseAndLevel = new BadgeBaseAndLevel(param1);
         var _loc4_:String = getExistingKey(["badge_instruction_" + _loc2_.base]);
         this.registerParameter(_loc4_,"limit","" + getBadgePointLimit(param1));
         var _loc3_:String = this.getLocalization(_loc4_);
         return _loc3_ ?? "";
      }
      
      public function getBadgeBaseName(param1:String) : String
      {
         var _loc2_:BadgeBaseAndLevel = new BadgeBaseAndLevel(param1);
         return _loc2_.base;
      }
      
      public function getBadgeName(param1:String) : String
      {
         var _loc2_:BadgeBaseAndLevel = new BadgeBaseAndLevel(param1);
         var _loc3_:String = fixBadLocalization(getExistingKey(["badge_name_" + param1,"badge_name_" + _loc2_.base]));
         this.registerParameter(_loc3_,"roman",getRomanNumeral(_loc2_.level));
         return this.getLocalization(_loc3_);
      }
      
      public function getBadgeDesc(param1:String) : String
      {
         var _loc3_:BadgeBaseAndLevel = new BadgeBaseAndLevel(param1);
         var _loc4_:String = fixBadLocalization(getExistingKey(["badge_desc_" + param1,"badge_desc_" + _loc3_.base]));
         this.registerParameter(_loc4_,"limit","" + getBadgePointLimit(param1));
         this.registerParameter(_loc4_,"roman",getRomanNumeral(_loc3_.level));
         var _loc2_:String = this.getLocalization(_loc4_);
         return _loc4_ == _loc2_ ? "" : _loc2_;
      }
      
      private function fixBadLocalization(param1:String) : String
      {
         var _loc2_:String = param1.replace("${","$");
         _loc2_ = _loc2_.replace("{","$");
         return _loc2_.replace("}","$");
      }
      
      public function getPreviousLevelBadgeId(param1:String) : String
      {
         var _loc2_:BadgeBaseAndLevel = new BadgeBaseAndLevel(param1);
         _loc2_.level--;
         return _loc2_.badgeId;
      }
      
      public function setBadgePointLimit(param1:String, param2:int) : void
      {
         var_3493[param1] = param2;
      }
      
      private function configureLocalizationLocations() : void
      {
         var _loc3_:String = null;
         var _loc2_:String = null;
         var _loc1_:String = null;
         var _loc5_:String = null;
         var _loc4_:int = 1;
         while(propertyExists("localization." + _loc4_))
         {
            _loc3_ = getProperty("localization." + _loc4_);
            _loc2_ = getProperty("localization." + _loc4_ + ".code");
            _loc1_ = getProperty("localization." + _loc4_ + ".name");
            _loc5_ = getProperty("localization." + _loc4_ + ".url");
            super.registerLocalizationDefinition(_loc3_,_loc1_,_loc5_,_loc2_);
            _loc4_++;
         }
      }
      
      public function requestLocalizationInit() : void
      {
         if(var_1816)
         {
            return;
         }
         var_1816 = true;
         events.addEventListener("LOCALIZATION_EVENT_LOCALIZATION_LOADED",onLocalizationLoaded);
         events.addEventListener("LOCALIZATION_EVENT_LOCALIZATION_FAILED",onManagerLocalizationFailed);
         super.loadLocalizationFromURL(getProperty("gamedata.hashes.url"),getProperty("environment.id"));
      }
      
      private function getBadgePointLimit(param1:String) : int
      {
         return var_3493[param1];
      }
      
      private function getExistingKey(param1:Array) : String
      {
         var _loc2_:String = null;
         for each(var _loc3_ in param1)
         {
            _loc2_ = this.getLocalization(_loc3_);
            if(_loc2_ != "")
            {
               return _loc3_;
            }
         }
         return param1[0];
      }
      
      private function getRomanNumeral(param1:int) : String
      {
         return _romanNumerals[Math.max(0,param1 - 1)];
      }
      
      private function parseDevelopmentLocalizations() : void
      {
      }
      
      private function onManagerLocalizationFailed(param1:Event) : void
      {
         var_1816 = false;
         class_23.crash("Failed loading gamedata hashes",8);
      }
      
      private function onLocalizationLoaded(param1:Event) : void
      {
         var_1816 = false;
         events.removeEventListener("LOCALIZATION_EVENT_LOCALIZATION_LOADED",onLocalizationLoaded);
         events.removeEventListener("LOCALIZATION_EVENT_LOCALIZATION_FAILED",onManagerLocalizationFailed);
         localizationsReady();
      }
      
      private function localizationsReady() : void
      {
         events.dispatchEvent(new Event("complete"));
      }
   }
}

