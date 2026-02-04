package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.newvariablepicker.tabbuttons
{
   public class TabButtonConfig
   {
      
      private var var_4125:int;
      
      private var _assetUri:String;
      
      private var var_5042:String;
      
      private var var_4168:Function;
      
      public function TabButtonConfig(param1:int, param2:String, param3:String, param4:Function)
      {
         super();
         var_4125 = param1;
         _assetUri = param2;
         var_5042 = param3;
         var_4168 = param4;
      }
      
      public function get tabId() : int
      {
         return var_4125;
      }
      
      public function get assetUri() : String
      {
         return _assetUri;
      }
      
      public function get tooltipCaption() : String
      {
         return var_5042;
      }
      
      public function get filteredVariables() : Function
      {
         return var_4168;
      }
   }
}

