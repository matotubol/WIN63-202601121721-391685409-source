package com.sulake.habbo.ui.widget.furniture.contextmenu
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.ui.widget.contextmenu.class_1853;
   
   public class MonsterPlantSeedContextMenuView extends FurnitureContextInfoView
   {
      
      private var var_3874:int;
      
      public function MonsterPlantSeedContextMenuView(param1:class_1853)
      {
         super(param1);
      }
      
      override protected function updateWindow() : void
      {
         var _loc1_:XML = null;
         if(!var_16 || !var_16.assets || !var_16.windowManager)
         {
            return;
         }
         if(var_530)
         {
            activeView = getMinimizedView();
         }
         else
         {
            if(!_window)
            {
               _loc1_ = XmlAsset(var_16.assets.getAssetByName("monsterplant_seed_menu")).content as XML;
               _window = var_16.windowManager.buildFromXML(_loc1_,0) as class_1812;
               if(!_window)
               {
                  return;
               }
               _window.addEventListener("WME_OVER",onMouseHoverEvent);
               _window.addEventListener("WME_OUT",onMouseHoverEvent);
               var _loc2_:class_1741 = _window.findChildByName("minimize");
            }
            _window.findChildByName("furni_name").caption = "${furni.mnstr_seed.name}";
            _window.findChildByName("buttons").procedure = buttonEventProc;
            _window.visible = false;
            activeView = _window;
            var_200 = false;
         }
      }
      
      override protected function buttonEventProc(param1:class_1758, param2:class_1741) : void
      {
         var _loc4_:FurnitureContextMenuWidget = null;
         if(disposed || !_window || Boolean(_window.disposed))
         {
            return;
         }
         var _loc3_:Boolean = false;
         if(param1.type == "WME_CLICK")
         {
            if(param2.name == "button")
            {
               var _loc5_:* = param2.parent.name;
               if("use" === _loc5_)
               {
                  _loc4_ = var_16 as FurnitureContextMenuWidget;
                  if(_loc4_ != null)
                  {
                     _loc4_.showPlantSeedConfirmationDialog(var_612);
                  }
               }
            }
            _loc3_ = true;
         }
         else
         {
            super.buttonEventProc(param1,param2);
         }
         if(_loc3_)
         {
            var_16.removeView(this,false);
         }
      }
      
      public function set objectCategory(param1:int) : void
      {
         var_3874 = param1;
      }
   }
}

