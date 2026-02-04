package com.sulake.habbo.ui.widget.chatinput.styleselector
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.class_1993;
   import com.sulake.habbo.session.ISessionDataManager;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class ChatStyleGridView implements class_13
   {
      
      private static const SCREEN_LEFT_BORDER:int = 92;
      
      private var _window:class_1993;
      
      private var var_3492:ChatStyleSelector;
      
      public function ChatStyleGridView(param1:ChatStyleSelector, param2:ISessionDataManager)
      {
         super();
         var_3492 = param1;
         var _loc3_:class_40 = param1.chatInputView.widget.assets;
         _window = class_1993(param1.chatInputView.widget.windowManager.buildFromXML(XML(_loc3_.getAssetByName("styleselector_menu_new_xml").content)));
         _window.visible = false;
      }
      
      public function dispose() : void
      {
         _window.dispose();
         _window = null;
         var_3492 = null;
      }
      
      public function get disposed() : Boolean
      {
         return _window == null;
      }
      
      public function get grid() : IItemGridWindow
      {
         return IItemGridWindow(_window.findChildByName("itemgrid"));
      }
      
      public function get window() : class_1993
      {
         return _window;
      }
      
      public function alignToSelector(param1:class_1812) : void
      {
         var _loc4_:Rectangle = new Rectangle();
         param1.getGlobalRectangle(_loc4_);
         var _loc3_:class_1812 = class_1812(_window.parent);
         _loc3_.x = _loc4_.right - _window.width;
         _loc3_.y = _loc4_.bottom - _window.height;
         var _loc5_:Point = new Point();
         _loc3_.getGlobalPosition(_loc5_);
         if(_loc5_.x < 92)
         {
            var _loc2_:int = 92 - _loc5_.x;
            _loc3_.x += 0;
         }
         _loc3_.x = _loc4_.x;
         _loc3_.y = _loc4_.bottom - 35 - _window.height;
      }
   }
}

