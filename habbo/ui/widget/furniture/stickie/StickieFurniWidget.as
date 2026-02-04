package com.sulake.habbo.ui.widget.furniture.stickie
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.events.RoomWidgetStickieDataUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetStickieSendUpdateMessage;
   import com.sulake.habbo.window.class_38;
   import flash.display.BitmapData;
   import flash.events.IEventDispatcher;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class StickieFurniWidget extends RoomWidgetBase
   {
      
      private static const FIELD_MAX_LINES:int = 14;
      
      private static const FIELD_MAX_CHARS:int = 500;
      
      private static const const_428:Number = 100;
      
      private static const const_356:Number = 100;
      
      private var _window:class_1812;
      
      protected var var_315:int = -1;
      
      protected var var_2300:String;
      
      protected var _text:String;
      
      protected var var_628:String;
      
      protected var var_55:Boolean;
      
      private var var_3394:BitmapData;
      
      protected var _windowName:String = "stickieui_container";
      
      public function StickieFurniWidget(param1:IRoomWidgetHandler, param2:class_38, param3:class_40 = null)
      {
         super(param1,param2,param3);
      }
      
      protected function get window() : class_1812
      {
         return _window;
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         hideInterface();
         if(var_3394)
         {
            var_3394.dispose();
         }
         super.dispose();
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener("RWSDUE_STICKIE_DATA",onObjectUpdate);
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener("RWSDUE_STICKIE_DATA",onObjectUpdate);
      }
      
      protected function onObjectUpdate(param1:RoomWidgetStickieDataUpdateEvent) : void
      {
         hideInterface(false);
         var_315 = param1.objectId;
         var_2300 = param1.objectType;
         _text = param1.text;
         var_628 = param1.colorHex;
         var_55 = param1.controller;
         showInterface();
      }
      
      protected function showInterface() : void
      {
         var _loc7_:ITextFieldWindow = null;
         var _loc4_:BitmapDataAsset = null;
         var _loc3_:BitmapData = null;
         var _loc2_:class_2251 = null;
         var _loc6_:String = null;
         if(var_315 == -1)
         {
            return;
         }
         var _loc5_:IAsset = assets.getAssetByName("stickie");
         if(_loc5_ == null)
         {
            return;
         }
         var _loc1_:XmlAsset = XmlAsset(_loc5_);
         if(_loc1_ == null)
         {
            return;
         }
         if(_window == null)
         {
            _window = windowManager.createWindow(_windowName,"",4,0,0x020000 | 1,new Rectangle(100,100,2,2),null,0) as class_1812;
            _window.buildFromXML(XML(_loc1_.content));
         }
         _loc7_ = _window.findChildByName("text") as ITextFieldWindow;
         if(_loc7_ != null)
         {
            _loc7_.text = _text;
            _loc7_.addEventListener("WE_CHANGE",onTextWindowEvent);
         }
         _loc2_ = _window.findChildByTag("bg") as class_2251;
         if(_loc2_ != null)
         {
            _loc6_ = var_2300.replace("post_it","stickie");
            if(assets.hasAsset(_loc6_) && assets.getAssetByName(_loc6_) is BitmapDataAsset)
            {
               _loc4_ = assets.getAssetByName(_loc6_) as BitmapDataAsset;
            }
            else
            {
               _loc4_ = assets.getAssetByName("stickie_blanco") as BitmapDataAsset;
               _loc2_.color = uint("0xFF" + var_628);
            }
            _loc3_ = _loc4_.content as BitmapData;
            if(var_3394)
            {
               _loc3_ = var_3394;
            }
            _loc2_.bitmap = new BitmapData(_loc2_.width,_loc2_.height,true,0);
            _loc2_.bitmap.copyPixels(_loc3_,_loc3_.rect,new Point(0,0));
         }
         _loc2_ = _window.findChildByTag("close_button") as class_2251;
         if(_loc2_ != null)
         {
            _loc4_ = assets.getAssetByName("stickie_close") as BitmapDataAsset;
            _loc3_ = _loc4_.content as BitmapData;
            _loc2_.bitmap = new BitmapData(_loc2_.width,_loc2_.height,true,0);
            _loc2_.bitmap.copyPixels(_loc3_,_loc3_.rect,new Point(0,0));
            _loc2_.addEventListener("WME_CLICK",onMouseEvent);
         }
         _loc2_ = _window.findChildByTag("delete_button") as class_2251;
         if(_loc2_ != null && var_55)
         {
            _loc4_ = assets.getAssetByName("stickie_remove") as BitmapDataAsset;
            _loc3_ = _loc4_.content as BitmapData;
            _loc2_.bitmap = new BitmapData(_loc2_.width,_loc2_.height,true,0);
            _loc2_.bitmap.copyPixels(_loc3_,_loc3_.rect,new Point(0,0));
            _loc2_.addEventListener("WME_CLICK",onMouseEvent);
         }
         setColorButtons(var_55 && var_2300 == "post_it");
      }
      
      protected function hideInterface(param1:Boolean = true) : void
      {
         if(param1)
         {
            sendUpdate();
         }
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         var_315 = -1;
         _text = null;
         var_55 = false;
      }
      
      private function setColorButtons(param1:Boolean) : void
      {
         var _loc2_:class_1741 = null;
         var _loc3_:int = 0;
         var _loc4_:Array = new Array("blue","purple","green","yellow");
         _loc3_ = 0;
         while(_loc3_ <= _loc4_.length)
         {
            _loc2_ = _window.findChildByName(_loc4_[_loc3_]);
            if(_loc2_ != null)
            {
               if(param1)
               {
                  _loc2_.visible = true;
                  _loc2_.addEventListener("WME_CLICK",onMouseEvent);
               }
               else
               {
                  _loc2_.visible = false;
               }
            }
            _loc3_++;
         }
      }
      
      protected function storeTextFromField() : Boolean
      {
         var _loc1_:ITextFieldWindow = _window.findChildByName("text") as ITextFieldWindow;
         if(_loc1_ == null)
         {
            return false;
         }
         if(_text == _loc1_.text)
         {
            return false;
         }
         _text = _loc1_.text;
         return true;
      }
      
      protected function sendUpdate() : void
      {
         var _loc1_:RoomWidgetStickieSendUpdateMessage = null;
         if(var_315 == -1)
         {
            return;
         }
         if(!storeTextFromField())
         {
            return;
         }
         if(messageListener != null)
         {
            _loc1_ = new RoomWidgetStickieSendUpdateMessage("RWSUM_STICKIE_SEND_UPDATE",var_315,_text,var_628);
            messageListener.processWidgetMessage(_loc1_);
         }
      }
      
      protected function sendSetColor(param1:uint) : void
      {
         if(var_315 == -1)
         {
            return;
         }
         storeTextFromField();
         var _loc2_:String = param1.toString(16).toUpperCase();
         if(_loc2_.length > 6)
         {
            _loc2_ = _loc2_.slice(_loc2_.length - 6,_loc2_.length);
         }
         if(_loc2_ == var_628)
         {
            return;
         }
         var_628 = _loc2_;
         if(messageListener != null)
         {
            var _loc3_:RoomWidgetStickieSendUpdateMessage = new RoomWidgetStickieSendUpdateMessage("RWSUM_STICKIE_SEND_UPDATE",var_315,_text,var_628);
            messageListener.processWidgetMessage(null);
         }
         showInterface();
      }
      
      protected function sendDelete() : void
      {
         var _loc1_:RoomWidgetStickieSendUpdateMessage = null;
         if(var_315 == -1)
         {
            return;
         }
         if(messageListener != null && var_55)
         {
            _loc1_ = new RoomWidgetStickieSendUpdateMessage("RWSUM_STICKIE_SEND_DELETE",var_315);
            messageListener.processWidgetMessage(_loc1_);
         }
      }
      
      private function onTextWindowEvent(param1:class_1758) : void
      {
         var _loc2_:ITextFieldWindow = null;
         _loc2_ = _window.findChildByName("text") as ITextFieldWindow;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.maxChars = 500;
         if(_loc2_.numLines < 14)
         {
            return;
         }
         _loc2_.text = _loc2_.text.slice(0,_loc2_.text.length - 1);
         _loc2_.maxChars = _loc2_.length;
      }
      
      protected function onMouseEvent(param1:WindowMouseEvent) : void
      {
         var _loc2_:class_1741 = param1.target as class_1741;
         var _loc3_:String = _loc2_.name;
         switch(_loc3_)
         {
            case "blue":
            case "purple":
            case "green":
            case "yellow":
               sendSetColor(_loc2_.color);
               break;
            case "close":
               hideInterface();
               break;
            case "delete":
               sendDelete();
               hideInterface(false);
         }
      }
   }
}

