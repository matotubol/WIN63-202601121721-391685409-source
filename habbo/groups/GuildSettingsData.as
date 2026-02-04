package com.sulake.habbo.groups
{
   import package_3.class_1818;
   
   public class GuildSettingsData
   {
      
      private var var_2266:int = 0;
      
      private var var_2678:int = 0;
      
      private var var_1866:Boolean = false;
      
      public function GuildSettingsData(param1:class_1818 = null)
      {
         super();
         if(param1 == null)
         {
            return;
         }
         var_2266 = param1.guildType;
         var_2678 = param1.guildRightsLevel;
      }
      
      public function get guildType() : int
      {
         return var_2266;
      }
      
      public function set guildType(param1:int) : void
      {
         if(param1 != var_2266)
         {
            var_1866 = true;
         }
         var_2266 = param1;
      }
      
      public function get rightsLevel() : int
      {
         return var_2678;
      }
      
      public function set rightsLevel(param1:int) : void
      {
         if(param1 != var_2678)
         {
            var_1866 = true;
         }
         var_2678 = param1;
      }
      
      public function get isModified() : Boolean
      {
         return var_1866;
      }
      
      public function resetModified() : void
      {
         var_1866 = false;
      }
   }
}

