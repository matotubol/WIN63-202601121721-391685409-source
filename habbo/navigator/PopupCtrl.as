package com.sulake.habbo.navigator
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   
   public class PopupCtrl
   {
      
      private var _navigator:HabboNavigator;
      
      private var _xmlFileName:String;
      
      private var var_3945:int;
      
      private var var_4269:int;
      
      private var var_862:Timer = new Timer(500,1);
      
      private var _hideTimer:Timer = new Timer(100,1);
      
      private var _popup:class_1812;
      
      public function PopupCtrl(param1:HabboNavigator, param2:int, param3:int, param4:String)
      {
         super();
         _navigator = param1;
         _xmlFileName = param4;
         var_3945 = param2;
         var_4269 = param3;
         var_862.addEventListener("timer",onDisplayTimer);
         _hideTimer.addEventListener("timer",onHideTimer);
      }
      
      public function get navigator() : HabboNavigator
      {
         return _navigator;
      }
      
      public function dispose() : void
      {
         _navigator = null;
         if(var_862)
         {
            var_862.removeEventListener("timer",onDisplayTimer);
            var_862.reset();
            var_862 = null;
         }
         if(_hideTimer)
         {
            _hideTimer.removeEventListener("timer",onHideTimer);
            _hideTimer.reset();
            _hideTimer = null;
         }
      }
      
      public function showPopup(param1:class_1741) : void
      {
         if(_popup == null)
         {
            _popup = class_1812(_navigator.getXmlWindow(_xmlFileName));
            _popup.visible = false;
            _popup.setParamFlag(1,true);
            _popup.procedure = onPopup;
         }
         Util.hideChildren(_popup);
         refreshContent(_popup);
         _popup.height = Util.getLowestPoint(_popup) + 5;
         var _loc2_:Point = new Point();
         param1.getGlobalPosition(_loc2_);
         _popup.x = _loc2_.x + var_3945 + param1.width;
         _popup.y = _loc2_.y - _popup.height * 0.5 + param1.height * 0.5;
         var _loc3_:Point = new Point();
         _popup.getGlobalPosition(_loc3_);
         if(_loc3_.x + _popup.width > _popup.desktop.width)
         {
            _popup.x = -_popup.width + _loc2_.x + var_4269;
            refreshPopupArrows(_popup,false);
         }
         else
         {
            refreshPopupArrows(_popup,true);
         }
         if(!_popup.visible)
         {
            var_862.reset();
            var_862.start();
         }
         _hideTimer.reset();
         _popup.activate();
      }
      
      public function closePopup() : void
      {
         _hideTimer.reset();
         var_862.reset();
         _hideTimer.start();
      }
      
      private function refreshPopupArrows(param1:class_1812, param2:Boolean) : void
      {
         refreshPopupArrow(param1,true,param2);
         refreshPopupArrow(param1,false,!param2);
      }
      
      private function refreshPopupArrow(param1:class_1812, param2:Boolean, param3:Boolean) : void
      {
         var _loc4_:String = "popup_arrow_" + (param2 ? "left" : "right");
         var _loc5_:class_2251 = class_2251(param1.findChildByName(_loc4_));
         if(!param3)
         {
            if(_loc5_ != null)
            {
               _loc5_.visible = false;
            }
         }
         else
         {
            if(_loc5_ == null)
            {
               _loc5_ = _navigator.getButton(_loc4_,_loc4_,null);
               _loc5_.setParamFlag(16,false);
               param1.addChild(_loc5_);
            }
            _loc5_.visible = true;
            _loc5_.y = param1.height * 0.5 - _loc5_.height * 0.5;
            _loc5_.x = param2 ? 1 - _loc5_.width : param1.width - 1;
         }
      }
      
      private function onDisplayTimer(param1:TimerEvent) : void
      {
         this._popup.visible = true;
         this._popup.activate();
      }
      
      private function onHideTimer(param1:TimerEvent) : void
      {
         if(_popup != null)
         {
            _popup.visible = false;
         }
      }
      
      public function hideInstantly() : void
      {
         if(_popup != null)
         {
            _popup.visible = false;
         }
         this.var_862.reset();
         this._hideTimer.reset();
      }
      
      public function get visible() : Boolean
      {
         return this._popup != null && Boolean(this._popup.visible);
      }
      
      public function refreshContent(param1:class_1812) : void
      {
      }
      
      private function onPopup(param1:class_1758, param2:class_1741) : void
      {
         if(param1 as WindowMouseEvent == null)
         {
            return;
         }
         if(param1.type == "WME_OVER")
         {
            this._hideTimer.reset();
         }
         else if(param1.type == "WME_OUT")
         {
            if(!Util.containsMouse(_popup))
            {
               this.closePopup();
            }
         }
      }
   }
}

