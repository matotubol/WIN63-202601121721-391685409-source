package com.sulake.habbo.ui.widget.chatinput.styleselector
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_1970;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.freeflowchat.style.class_2133;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.ui.widget.chatinput.RoomChatInputView;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.display.Sprite;
   
   public class ChatStyleSelector implements class_13
   {
      
      private static const GRID_SPACING:int = 1;
      
      private static const MAX_GRID_COLUMNS:int = 6;
      
      private static var _selected:ChatStyleGridEntry = null;
      
      private static var _styleRequiresUpdate:Boolean = false;
      
      private var var_1289:RoomChatInputView;
      
      private var _container:class_1812;
      
      private var var_237:ChatStyleGridView;
      
      private var var_80:Vector.<ChatStyleGridEntry> = new Vector.<ChatStyleGridEntry>();
      
      private var var_2591:class_1741;
      
      private var var_604:Shape;
      
      public function ChatStyleSelector(param1:RoomChatInputView, param2:class_1812, param3:ISessionDataManager)
      {
         super();
         var_1289 = param1;
         var_237 = new ChatStyleGridView(this,var_1289.sessionDataManager);
         var_2591 = param1.widget.windowManager.buildFromXML(param1.widget.assets.getAssetByName("chatinput_chatstyle_template_xml").content as XML);
         _container = param2;
         _container.procedure = windowProc;
         var_1289.chatStyleMenuContainer.addChild(var_237.window);
         var_237.window.x = 0;
         var_237.window.y = 0;
      }
      
      public function dispose() : void
      {
         while(var_80.length > 1)
         {
            var_80.pop();
         }
         var_80 = null;
         var_237.dispose();
         var_237 = null;
         if(var_604 && var_604.parent)
         {
            var_604.parent.removeChild(var_604);
         }
      }
      
      public function get disposed() : Boolean
      {
         return var_237 == null;
      }
      
      public function get chatInputView() : RoomChatInputView
      {
         return var_1289;
      }
      
      public function addItem(param1:int, param2:BitmapData) : void
      {
         var_80.push(new ChatStyleGridEntry(param1,param2));
         var _loc3_:class_1812 = getGridItemWindowWrapper(param2);
         var_237.grid.addGridItem(_loc3_);
         _loc3_.findChildByName("background_color").visible = false;
      }
      
      public function clear() : void
      {
         var_80.splice(0,var_80.length);
         var_237.grid.removeGridItems();
      }
      
      public function get selectedStyleId() : int
      {
         if(_styleRequiresUpdate && selected)
         {
            _styleRequiresUpdate = false;
            return selected.id;
         }
         return -1;
      }
      
      public function get selectedStyleBitmap() : BitmapData
      {
         if(selected)
         {
            return selected.bitmap;
         }
         return null;
      }
      
      public function initSelection() : void
      {
         selected = selected;
         _styleRequiresUpdate = false;
      }
      
      public function set gridColumns(param1:int) : void
      {
         param1 = Math.min(param1,6);
         var _loc2_:int = (param1 - 1) * (var_2591.width + 1) + var_2591.width;
         if(param1 > 1)
         {
            var_237.grid.width = _loc2_;
         }
         else
         {
            var_237.grid.width = var_2591.width + 16;
         }
      }
      
      private function set selected(param1:ChatStyleGridEntry) : void
      {
         _selected = param1;
         _styleRequiresUpdate = true;
         var _loc4_:class_2133 = var_1289.widget.roomUi.chatStyleLibrary.getStyle(param1.id);
         if(var_1289.window.findChildByName("chat_bg_preview") == null)
         {
            return;
         }
         var _loc2_:Sprite = _loc4_.getNewBackgroundSprite(16777215);
         var _loc3_:class_1970 = class_1970(var_1289.window.findChildByName("chat_bg_preview"));
         _loc2_.width = _loc3_.width + _loc4_.overlap.width;
         _loc2_.height = _loc3_.height + _loc4_.overlap.y + _loc4_.overlap.height;
         _loc2_.y -= _loc4_.overlap.y;
         if(!var_604)
         {
            var_604 = new Shape();
         }
         else
         {
            var_604.graphics.clear();
         }
         var_604.graphics.beginFill(16711680);
         var_604.graphics.drawRect(0,0,_loc2_.width - 28,_loc2_.height);
         _loc3_.setDisplayObject(_loc2_);
         if(_loc2_.parent)
         {
            _loc2_.parent.addChild(var_604);
            var_604.x = _loc2_.x + 28;
            var_604.y = _loc2_.y;
            _loc2_.mask = var_604;
         }
         var_1289.setInputFieldColor(_loc4_.textFormat.color as uint);
      }
      
      private function get selected() : ChatStyleGridEntry
      {
         if(_selected == null)
         {
            _selected = var_80[var_80.length - 1];
         }
         return _selected;
      }
      
      private function getGridItemWindowWrapper(param1:BitmapData) : class_1812
      {
         var _loc2_:class_1812 = class_1812(var_2591.clone());
         var _loc3_:class_2251 = class_2251(_loc2_.findChildByName("bubble_preview"));
         _loc3_.bitmap = param1;
         _loc3_.center();
         _loc2_.procedure = gridItemWindowProc;
         return _loc2_;
      }
      
      public function alignMenuToSelector() : void
      {
         if(var_237.window.visible)
         {
            var_237.alignToSelector(_container);
         }
      }
      
      private function windowProc(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            var_237.window.visible = !var_237.window.visible;
            alignMenuToSelector();
         }
      }
      
      private function gridItemWindowProc(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            var _loc3_:int = var_237.grid.getGridItemIndex(param2);
            showBackgroundOnlyForItem(param2);
            selected = var_80[0];
            var_237.window.visible = false;
         }
         if(param1.type == "WME_OVER")
         {
            class_1812(param2).findChildByName("background_color").color = 4291875024;
         }
         if(param1.type == "WME_OUT")
         {
            class_1812(param2).findChildByName("background_color").color = 4294967295;
         }
      }
      
      private function showBackgroundOnlyForItem(param1:class_1741) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < var_237.grid.numGridItems)
         {
            class_1812(var_237.grid.getGridItemAt(_loc2_)).findChildByName("background_color").visible = false;
            _loc2_++;
         }
         class_1812(param1).findChildByName("background_color").visible = true;
      }
   }
}

