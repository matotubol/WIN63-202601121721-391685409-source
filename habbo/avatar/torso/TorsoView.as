package com.sulake.habbo.avatar.torso
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.avatar.common.CategoryBaseView;
   import com.sulake.habbo.avatar.common.class_3708;
   
   public class TorsoView extends CategoryBaseView implements class_3708
   {
      
      public function TorsoView(param1:TorsoModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         if(!_window)
         {
            _window = var_36.controller.view.getCategoryContainer("torso") as class_1812;
            _window.visible = false;
            _window.procedure = windowEventProc;
         }
         var_265 = true;
         if(var_36 && var_145 == "")
         {
            var_36.switchCategory("ch");
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         var_36 = null;
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
            case "ch":
               _currentTabName = "tab_shirt";
               break;
            case "cc":
               _currentTabName = "tab_jacket";
               break;
            case "cp":
               _currentTabName = "tab_prints";
               break;
            case "ca":
               _currentTabName = "tab_accessories";
               break;
            default:
               throw new Error("[TorsoView] Unknown item category: \"" + param1 + "\"");
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
               case "tab_jacket":
                  switchCategory("cc");
                  break;
               case "tab_shirt":
                  switchCategory("ch");
                  break;
               case "tab_accessories":
                  switchCategory("ca");
                  break;
               case "tab_prints":
                  switchCategory("cp");
            }
         }
         else if(param1.type == "WME_OVER")
         {
            switch(param2.name)
            {
               case "tab_jacket":
               case "tab_prints":
               case "tab_shirt":
               case "tab_accessories":
                  activateTab(param2.name);
            }
         }
         else if(param1.type == "WME_OUT")
         {
            switch(param2.name)
            {
               case "tab_jacket":
               case "tab_prints":
               case "tab_shirt":
               case "tab_accessories":
                  if(_currentTabName != param2.name)
                  {
                     inactivateTab(param2.name);
                  }
            }
         }
      }
   }
}

