package com.sulake.habbo.avatar.generic
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.avatar.common.CategoryBaseView;
   import com.sulake.habbo.avatar.common.class_2582;
   import com.sulake.habbo.avatar.common.class_3708;
   
   public class BodyView extends CategoryBaseView implements class_3708
   {
      
      private const TAB_BOY_ID:String = "tab_boy";
      
      private const TAB_GIRL_ID:String = "tab_girl";
      
      public function BodyView(param1:class_2582)
      {
         super(param1);
         var_145 = "hd";
      }
      
      override public function reset() : void
      {
         super.reset();
         var_145 = "hd";
      }
      
      override public function init() : void
      {
         if(!_window)
         {
            _window = var_36.controller.view.getCategoryContainer("generic") as class_1812;
            _window.visible = false;
            _window.procedure = windowEventProc;
         }
         updateGridView("hd");
         var_265 = true;
         updateGenderTab();
      }
      
      override public function getWindowContainer() : class_1812
      {
         if(!var_265)
         {
            init();
         }
         updateGenderTab();
         return _window;
      }
      
      public function updateGenderTab() : void
      {
         if(var_36 == null)
         {
            return;
         }
         switch(var_36.controller.gender)
         {
            case "M":
               activateTab("tab_boy");
               inactivateTab("tab_girl");
               break;
            case "F":
               activateTab("tab_girl");
               inactivateTab("tab_boy");
         }
      }
      
      public function switchCategory(param1:String) : void
      {
         updateGenderTab();
         updateGridView(param1 == "" ? var_145 : param1);
      }
      
      private function windowEventProc(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "tab_boy":
                  var_36.controller.gender = "M";
                  param1.stopPropagation();
                  break;
               case "tab_girl":
                  var_36.controller.gender = "F";
                  param1.stopPropagation();
            }
         }
         else if(param1.type == "WME_OVER")
         {
            switch(param2.name)
            {
               case "tab_boy":
               case "tab_girl":
                  activateTab(param2.name);
            }
         }
         else if(param1.type == "WME_OUT")
         {
            switch(param2.name)
            {
               case "tab_boy":
               case "tab_girl":
                  updateGenderTab();
            }
         }
      }
   }
}

