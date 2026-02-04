package com.sulake.habbo.roomevents.wired_menu.tabs
{
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.roomevents.wired_menu.WiredMenuController;
   
   public class WiredMenuTabConfig
   {
      
      private var var_197:String;
      
      private var var_3424:Class;
      
      private var var_4632:Boolean;
      
      private var var_4825:Boolean;
      
      private var var_3091:Boolean;
      
      public function WiredMenuTabConfig(param1:String, param2:Class, param3:Boolean = true, param4:Boolean = true, param5:Boolean = true)
      {
         super();
         var_197 = param1;
         var_3424 = param2;
         var_4632 = param3;
         var_4825 = param4;
         var_3091 = param5;
      }
      
      public function get id() : String
      {
         return var_197;
      }
      
      public function get tabButtonName() : String
      {
         return "top_view_" + var_197 + "_button";
      }
      
      public function get containerName() : String
      {
         return var_197 + "_container";
      }
      
      public function get titleLocalizationKey() : String
      {
         return "wiredmenu." + var_197 + ".title";
      }
      
      public function createTab(param1:WiredMenuController, param2:class_1812) : class_2710
      {
         return new var_3424(param1,param2);
      }
      
      public function get isCreateImmediately() : Boolean
      {
         return var_4632;
      }
      
      public function get isReusable() : Boolean
      {
         return var_4825;
      }
      
      public function get isEnabled() : Boolean
      {
         return var_3091;
      }
   }
}

