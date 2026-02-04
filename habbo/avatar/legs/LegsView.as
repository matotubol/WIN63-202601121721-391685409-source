package com.sulake.habbo.avatar.legs
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.avatar.common.CategoryBaseView;
   import com.sulake.habbo.avatar.common.class_2582;
   import com.sulake.habbo.avatar.common.class_3708;
   
   public class LegsView extends CategoryBaseView implements class_3708
   {
      
      public function LegsView(param1:class_2582)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         if(!_window)
         {
            _window = var_36.controller.view.getCategoryContainer("legs") as class_1812;
            _window.visible = false;
            _window.procedure = windowEventProc;
         }
         var_265 = true;
         if(var_36 && var_145 == "")
         {
            var_36.switchCategory("lg");
         }
      }
      
      public function switchCategory(param1:String) : void
      {
         if(_window == null)
         {
            return;
         }
         if(_window.disposed)
         {
            return;
         }
         param1 = param1 == "" ? var_145 : param1;
         inactivateTab(_currentTabName);
         switch(param1)
         {
            case "lg":
               _currentTabName = "tab_pants";
               break;
            case "sh":
               _currentTabName = "tab_shoes";
               break;
            case "wa":
               _currentTabName = "tab_belts";
               break;
            default:
               throw new Error("[LegsView] Unknown item category: \"" + param1 + "\"");
         }
         var_145 = param1;
         activateTab(_currentTabName);
         if(!var_265)
         {
            init();
         }
         updateGridView(var_145);
      }
      
      private function windowEventProc(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "tab_pants":
                  switchCategory("lg");
                  break;
               case "tab_shoes":
                  switchCategory("sh");
                  break;
               case "tab_belts":
                  switchCategory("wa");
            }
         }
         else if(param1.type == "WME_OVER")
         {
            switch(param2.name)
            {
               case "tab_pants":
               case "tab_shoes":
               case "tab_belts":
                  activateTab(param2.name);
            }
         }
         else if(param1.type == "WME_OUT")
         {
            switch(param2.name)
            {
               case "tab_pants":
               case "tab_shoes":
               case "tab_belts":
                  if(_currentTabName != param2.name)
                  {
                     inactivateTab(param2.name);
                  }
            }
         }
      }
   }
}

