package com.sulake.habbo.ui.widget.furniture.guildfurnicontextmenu
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.runtime.class_17;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.groups.class_140;
   import com.sulake.habbo.ui.widget.contextmenu.class_1853;
   import com.sulake.habbo.ui.widget.furniture.contextmenu.FurnitureContextInfoView;
   import com.sulake.habbo.ui.widget.furniture.contextmenu.FurnitureContextMenuWidget;
   import com.sulake.habbo.window.class_38;
   
   public class GuildFurnitureContextMenuView extends FurnitureContextInfoView
   {
      
      protected var var_2120:class_140;
      
      protected var _windowManager:class_38;
      
      public var var_3004:int = -1;
      
      public var var_2816:int = -1;
      
      public var var_3215:Boolean = false;
      
      public var var_2695:Boolean = false;
      
      public function GuildFurnitureContextMenuView(param1:class_1853, param2:class_140, param3:class_38)
      {
         super(param1);
         var_236 = false;
         var_2120 = param2;
         _windowManager = param3;
      }
      
      override public function dispose() : void
      {
         var_2120 = null;
         _windowManager = null;
         super.dispose();
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
               _loc1_ = XmlAsset(var_16.assets.getAssetByName("guild_furni_menu")).content as XML;
               _window = var_16.windowManager.buildFromXML(_loc1_,0) as class_1812;
               if(!_window)
               {
                  return;
               }
               _window.addEventListener("WME_OVER",onMouseHoverEvent);
               _window.addEventListener("WME_OUT",onMouseHoverEvent);
               _window.findChildByName("minimize").addEventListener("WME_CLICK",onMinimize);
               _window.findChildByName("minimize").addEventListener("WME_OVER",onMinimizeHover);
               _window.findChildByName("minimize").addEventListener("WME_OUT",onMinimizeHover);
            }
            var_34 = _window.findChildByName("buttons") as IItemListWindow;
            var_34.procedure = buttonEventProc;
            var _loc2_:IRegionWindow = _window.findChildByName("profile_link") as IRegionWindow;
            _window.findChildByName("name").caption = var_839;
            _window.visible = false;
            activeView = _window;
            updateButtons();
            var_200 = false;
         }
      }
      
      protected function updateButtons() : void
      {
         if(!_window || !var_34)
         {
            return;
         }
         var_34.autoArrangeItems = false;
         showButton("join",!var_3215,true);
         showButton("open_forum",var_2695,true);
         var_34.autoArrangeItems = true;
         var_34.visible = true;
      }
      
      override protected function buttonEventProc(param1:class_1758, param2:class_1741) : void
      {
         var _loc4_:class_17 = null;
         if(disposed)
         {
            return;
         }
         if(!_window || Boolean(_window.disposed))
         {
            return;
         }
         var _loc3_:Boolean = false;
         if(param1.type == "WME_CLICK")
         {
            if(param2.name == "button")
            {
               switch(param2.parent.name)
               {
                  case "join":
                     widget.handler.sendJoinToGroupMessage(var_3004);
                     showButton("join",!var_3215,false);
                     break;
                  case "home_room":
                     widget.handler.sendGoToHomeRoomMessage(var_2816);
                     break;
                  case "open_forum":
                     if(widget != null && widget.roomEngine != null)
                     {
                        _loc4_ = widget.roomEngine as class_17;
                        if(_loc4_.context != null)
                        {
                           _loc4_.context.createLinkEvent("groupforum/" + var_3004);
                        }
                     }
               }
            }
            if(param2.name == "profile_link")
            {
               var_2120.openGroupInfo(var_3004);
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
      
      private function get widget() : FurnitureContextMenuWidget
      {
         return var_16 as FurnitureContextMenuWidget;
      }
   }
}

