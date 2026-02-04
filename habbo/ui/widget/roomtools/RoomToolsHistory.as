package com.sulake.habbo.ui.widget.roomtools
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.ui.handler.RoomToolsWidgetHandler;
   import com.sulake.habbo.window.class_38;
   import package_42.class_1945;
   
   public class RoomToolsHistory
   {
      
      private static const PADDING:int = 5;
      
      private static const SPACING:int = 2;
      
      private var _windowManager:class_38;
      
      private var _assets:class_40;
      
      private var _window:class_1812;
      
      private var var_41:RoomToolsWidgetHandler;
      
      private var _items:Vector.<class_1812> = new Vector.<class_1812>();
      
      public function RoomToolsHistory(param1:class_38, param2:class_40, param3:RoomToolsWidgetHandler)
      {
         super();
         var_41 = param3;
         _assets = param2;
         _windowManager = param1;
         _window = param1.buildFromXML(param2.getAssetByName("room_tools_history_xml").content as XML) as class_1812;
      }
      
      public function populate(param1:Vector.<class_1945>) : void
      {
         var _loc3_:class_1741 = null;
         var _loc2_:class_1812 = null;
         for each(var _loc4_ in param1)
         {
            _loc2_ = _windowManager.buildFromXML(_assets.getAssetByName("room_tools_history_item_xml").content as XML) as class_1812;
            _window.addChild(_loc2_);
            _loc2_.findChildByName("room_name").caption = _loc4_.roomName;
            if(_loc3_)
            {
               _loc2_.y = _loc3_.bottom + 2;
            }
            else
            {
               _loc2_.y = 5;
            }
            _loc2_.x = 5;
            _loc2_.id = _loc4_.flatId;
            _loc2_.procedure = onClick;
            _loc3_ = _loc2_;
            _items.push(_loc2_);
         }
         if(_loc3_)
         {
            _window.height = _loc3_.bottom + 2 * 5;
         }
      }
      
      public function dispose() : void
      {
         for each(var _loc1_ in _items)
         {
            _loc1_.procedure = null;
            _loc1_.dispose();
         }
         _items = null;
         _windowManager = null;
         var_41 = null;
         _assets = null;
         _window.dispose();
         _window = null;
      }
      
      private function onClick(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var_41.goToPrivateRoom(param2.id);
      }
      
      public function get window() : class_1812
      {
         return _window;
      }
   }
}

