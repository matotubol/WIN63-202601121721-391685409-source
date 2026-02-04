package com.sulake.habbo.ui.widget.roomchat
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ILabelWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.ui.widget.events.RoomWidgetChatUpdateEvent;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.window.class_38;
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   import flash.text.TextFormat;
   
   public class RoomChatItem
   {
      
      public static const CHAT_ITEM_STACKING_HEIGHT:Number = 18;
      
      private static const MESSAGE_TEXT_MARGIN_LEFT:int = 6;
      
      private static const MESSAGE_TEXT_MARGIN_RIGHT:int = 6;
      
      private static const RESPECT_ICON_MARGIN_RIGHT:int = 35;
      
      private static const const_972:int = 26;
      
      private static const NAME:String = "name";
      
      private static const MESSAGE:String = "message";
      
      private static const POINTER:String = "pointer";
      
      private static const BACKGROUND:String = "background";
      
      private static const TOOLTIP_DRAG_FOR_HISTORY:String = "${chat.history.drag.tooltip}";
      
      private var var_16:RoomChatWidget;
      
      private var _windowManager:class_38;
      
      private var var_167:class_27;
      
      private var _window:IRegionWindow;
      
      private var var_909:class_40;
      
      private var var_197:String;
      
      private var var_3677:String;
      
      private var _aboveLevels:int = 0;
      
      private var var_3926:int = -1;
      
      private var var_665:int;
      
      private var var_1773:int;
      
      private var var_1229:int;
      
      private var _senderName:String = new String();
      
      private var var_986:String = new String();
      
      private var var_790:Array;
      
      private var var_1629:Array;
      
      private var var_2416:int;
      
      private var var_3337:Number;
      
      private var var_339:BitmapData;
      
      private var _senderColor:uint;
      
      private var var_1951:int;
      
      private var var_3359:int;
      
      private var var_4522:int;
      
      private var var_2675:int;
      
      private var _width:Number = 0;
      
      private var var_3086:Boolean = false;
      
      private var _topOffset:Number = 0;
      
      private var _originalBackgroundYOffset:Number = 0;
      
      private var var_25:Number = 0;
      
      private var var_26:Number = 0;
      
      private var var_3382:Boolean = false;
      
      public function RoomChatItem(param1:RoomChatWidget, param2:class_38, param3:class_40, param4:String, param5:class_27, param6:String)
      {
         super();
         var_16 = param1;
         _windowManager = param2;
         var_909 = param3;
         var_197 = param4;
         var_167 = param5;
         var_3677 = param6;
      }
      
      public function dispose() : void
      {
         if(_window != null)
         {
            _window.dispose();
            _window = null;
            var_16 = null;
            _windowManager = null;
            var_167 = null;
            var_339 = null;
         }
      }
      
      public function define(param1:RoomWidgetChatUpdateEvent) : void
      {
         var_665 = param1.chatType;
         var_1773 = param1.styleId;
         var_1229 = param1.userId;
         _senderName = param1.userName;
         var_2675 = param1.userCategory;
         var_986 = param1.text;
         var_790 = param1.links;
         var_3337 = param1.userX;
         var_339 = param1.userImage;
         _senderColor = param1.userColor;
         var_1951 = param1.roomId;
         var_3359 = param1.userType;
         var_4522 = param1.petType;
         renderView();
      }
      
      public function set message(param1:String) : void
      {
         var_986 = param1;
      }
      
      public function set senderName(param1:String) : void
      {
         _senderName = param1;
      }
      
      public function set senderImage(param1:BitmapData) : void
      {
         var_339 = param1;
      }
      
      public function set senderColor(param1:uint) : void
      {
         _senderColor = param1;
      }
      
      public function set chatType(param1:int) : void
      {
         var_665 = param1;
      }
      
      public function get view() : class_1812
      {
         return _window;
      }
      
      public function get screenLevel() : int
      {
         return var_3926;
      }
      
      public function get timeStamp() : int
      {
         return var_2416;
      }
      
      public function get senderX() : Number
      {
         return var_3337;
      }
      
      public function set senderX(param1:Number) : void
      {
         var_3337 = param1;
      }
      
      public function get width() : Number
      {
         return _width;
      }
      
      public function get height() : Number
      {
         return 18;
      }
      
      public function get message() : String
      {
         return var_986;
      }
      
      public function get x() : Number
      {
         return var_25;
      }
      
      public function get y() : Number
      {
         return var_26;
      }
      
      public function get aboveLevels() : int
      {
         return _aboveLevels;
      }
      
      public function set aboveLevels(param1:int) : void
      {
         _aboveLevels = param1;
      }
      
      public function set screenLevel(param1:int) : void
      {
         var_3926 = param1;
      }
      
      public function set timeStamp(param1:int) : void
      {
         var_2416 = param1;
      }
      
      public function set x(param1:Number) : void
      {
         var_25 = param1;
         if(_window != null)
         {
            _window.x = param1;
         }
      }
      
      public function set y(param1:Number) : void
      {
         var_26 = param1;
         if(_window != null)
         {
            _window.y = param1 - _topOffset + _originalBackgroundYOffset;
         }
      }
      
      public function hidePointer() : void
      {
         var _loc1_:class_1741 = null;
         if(_window)
         {
            _loc1_ = _window.findChildByName("pointer");
            if(_loc1_)
            {
               _loc1_.visible = false;
            }
         }
      }
      
      public function setPointerOffset(param1:Number) : void
      {
         if(!_window || Boolean(_window.disposed))
         {
            return;
         }
         var _loc3_:class_2251 = _window.findChildByName("pointer") as class_2251;
         var _loc2_:class_2251 = _window.findChildByName("middle") as class_2251;
         if(_loc2_ == null || _loc3_ == null)
         {
            return;
         }
         _loc3_.visible = true;
         param1 += _window.width / 2;
         param1 = Math.min(param1,_loc2_.rectangle.right - _loc3_.width);
         param1 = Math.max(param1,_loc2_.rectangle.left);
         _loc3_.x = param1;
      }
      
      public function checkOverlap(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number) : Boolean
      {
         var _loc6_:Rectangle = new Rectangle(var_25,var_26,width,param1);
         var _loc7_:Rectangle = new Rectangle(param2,param3,param4,param5);
         return _loc6_.intersects(_loc7_);
      }
      
      public function hideView() : void
      {
         if(_window)
         {
            _window.dispose();
         }
         _window = null;
         var_3086 = false;
      }
      
      private function get isNotify() : Boolean
      {
         return var_1773 == 1;
      }
      
      public function renderView() : void
      {
         if(var_3086)
         {
            return;
         }
         var_3086 = true;
         if(_window)
         {
            return;
         }
         _window = RoomChatWidget.chatBubbleFactory.getBubbleWindow(var_1773,var_665);
         if(!_window)
         {
            return;
         }
         _window.toolTipIsDynamic = true;
         var _loc9_:class_2251 = _window.findChildByName("background") as class_2251;
         var _loc13_:ILabelWindow = _window.findChildByName("name") as ILabelWindow;
         var _loc5_:ITextWindow = _window.findChildByName("message") as ITextWindow;
         var _loc3_:class_2251 = _window.findChildByName("pointer") as class_2251;
         var _loc1_:Number = Number(_window.height);
         var _loc19_:BitmapData = RoomChatWidget.chatBubbleFactory.getPointerBitmapData(var_1773);
         _originalBackgroundYOffset = _loc9_.y;
         var _loc8_:int = _loc5_.x <= 26 ? 0 : _loc5_.x - 26;
         if(var_339 != null)
         {
            _topOffset = Math.max(0,(var_339.height - _loc9_.height) / 2);
            _loc1_ = Math.max(_loc1_,var_339.height);
            _loc1_ = Math.max(_loc1_,_loc9_.height);
         }
         _width = 0;
         _window.x = var_25;
         _window.y = var_26;
         _window.width = 0;
         _window.height = _loc1_;
         enableDragTooltip();
         addEventListeners(_window);
         if(var_339 && !isNotify)
         {
            var _loc15_:class_2251 = _window.findChildByName("user_image") as class_2251;
            if(_loc15_)
            {
               null.width = var_339.width;
               null.height = var_339.height;
               null.bitmap = var_339;
               null.disposesBitmap = false;
               var _loc14_:int = null.x - var_339.width / 2;
               var _loc12_:int = Math.max(0,(_loc9_.height - var_339.height) / 2);
               if(var_3359 == 2)
               {
                  while(true)
                  {
                     if(var_4522 == 15)
                     {
                        if(var_339.height > _loc9_.height)
                        {
                           _loc12_ = (var_339.height - _loc9_.height) / 2;
                        }
                     }
                  }
                  §§goto(addr01f5);
               }
               null.x = 0;
               null.y += 0;
               _width += null.x + var_339.width;
            }
         }
         addr01f5:
         if(_loc13_ != null)
         {
            if(!isNotify)
            {
               _loc13_.text = _senderName + ": ";
               _loc13_.y += _topOffset;
               _loc13_.width = _loc13_.textWidth + 6;
            }
            else
            {
               _loc13_.text = "";
               _loc13_.width = 0;
            }
            _width += _loc13_.width;
         }
         if(var_665 == 3)
         {
            _loc5_.text = var_167.registerParameter("widgets.chatbubble.respect","username",_senderName);
            _width = 35;
         }
         else if(var_665 == 4)
         {
            _loc5_.text = var_167.registerParameter("widget.chatbubble.petrespect","petname",_senderName);
            _width = 35;
         }
         else if(var_665 == 6)
         {
            _loc5_.text = var_167.registerParameter("widget.chatbubble.pettreat","petname",_senderName);
            _width = 35;
         }
         else if(var_665 == 7)
         {
            _loc5_.text = message;
            _width = 35;
         }
         else if(var_665 == 8)
         {
            _loc5_.text = message;
            _width = 35;
         }
         else if(var_665 == 9)
         {
            _loc5_.text = message;
            _width = 35;
         }
         else if(var_665 == 5)
         {
            _loc5_.text = message;
            _width = 35;
         }
         else if(var_790 == null)
         {
            _loc5_.text = message;
         }
         else
         {
            var_1629 = [];
            var _loc7_:int = -1;
            var _loc4_:int = 0;
            while(0 < var_790.length)
            {
               var _loc17_:String = var_790[0][1];
               var _loc18_:String = "{" + 0 + "}";
               var _loc2_:int = int(var_986.indexOf(null));
               _loc7_ = 0 + null.length;
               var_1629.push([0,0]);
               var_986 = var_986.replace(null,null);
               _loc4_++;
            }
            _loc5_.text = message;
            _loc5_.immediateClickMode = true;
            _loc5_.setParamFlag(16,false);
            _loc5_.setParamFlag(1073741824,true);
            var _loc20_:TextFormat = _loc5_.getTextFormat();
            switch(var_1773 - 2)
            {
               case 0:
                  null.color = 14540253;
                  break;
               default:
                  null.color = 2710438;
            }
            null.underline = true;
            _loc4_ = 0;
            while(0 < var_1629.length)
            {
               var _loc10_:Array = var_1629[0];
               try
               {
                  _loc5_.setTextFormat(null,null[0],null[1]);
               }
               catch(e:RangeError)
               {
                  class_21.log("Chat message links were malformed. Could not set TextFormat");
               }
               _loc4_++;
            }
         }
         if(_loc5_.visible)
         {
            _loc5_.x = _width + _loc8_;
            if(_loc13_ != null)
            {
               _loc5_.x = _loc13_.x + _loc13_.width;
               while(true)
               {
                  if(_loc13_.width > 6)
                  {
                     _loc5_.x -= 6 - 1;
                  }
               }
               §§goto(addr04c8);
            }
            _loc5_.y += _topOffset;
            var _loc16_:int = _loc5_.textWidth;
            _loc5_.width = 0 + 6;
            _width += _loc5_.width;
         }
         addr04c8:
         if(_loc3_ != null && Boolean(_loc3_.visible))
         {
            _loc3_.bitmap = _loc19_;
            _loc3_.disposesBitmap = false;
            _loc3_.x = _width / 2;
            _loc3_.y += _topOffset;
         }
         var _loc6_:int = int(_loc5_.width);
         if(_loc13_)
         {
            _loc6_ += _loc13_.width;
         }
         var _loc11_:BitmapData = RoomChatWidget.chatBubbleFactory.buildBubbleImage(var_1773,var_665,_loc6_,_loc9_.height,_senderColor);
         _window.width = _loc11_.width;
         _window.y -= _topOffset;
         _window.y += _originalBackgroundYOffset;
         _width = _window.width;
         _loc9_.bitmap = _loc11_;
         _loc9_.y = _topOffset;
      }
      
      public function enableDragTooltip() : void
      {
         var_3382 = true;
         refreshTooltip();
      }
      
      public function disableDragTooltip() : void
      {
         var_3382 = false;
         refreshTooltip();
      }
      
      private function refreshTooltip() : void
      {
         if(_window == null)
         {
            return;
         }
         _window.toolTipCaption = "";
         if(var_16.isGameSession)
         {
            return;
         }
         if(var_3382)
         {
            _window.toolTipCaption = "${chat.history.drag.tooltip}";
         }
         _window.toolTipDelay = 500;
      }
      
      private function addEventListeners(param1:class_1812) : void
      {
         param1.setParamFlag(1,true);
         param1.addEventListener("WME_CLICK",onBubbleMouseClick);
         param1.addEventListener("WME_DOWN",onBubbleMouseDown);
         param1.addEventListener("WME_OVER",onBubbleMouseOver);
         param1.addEventListener("WME_OUT",onBubbleMouseOut);
         param1.addEventListener("WME_UP",onBubbleMouseUp);
      }
      
      private function testMessageLinkMouseClick(param1:int, param2:int) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:ITextWindow = _window.getChildByName("message") as ITextWindow;
         var _loc5_:int = _loc4_.getCharIndexAtPoint(param1 - _loc4_.x,param2 - _loc4_.y);
         if(_loc5_ > -1)
         {
            _loc3_ = 0;
            while(_loc3_ < var_1629.length)
            {
               if(_loc5_ >= var_1629[_loc3_][0] && _loc5_ <= var_1629[_loc3_][1])
               {
                  if(var_790[_loc3_][2] == 0)
                  {
                     HabboWebTools.openExternalLinkWarning(var_790[_loc3_][0]);
                  }
                  else if(var_790[_loc3_][2] == 1)
                  {
                     HabboWebTools.openWebPage(var_3677 + var_790[_loc3_][0],"habboMain");
                  }
                  else
                  {
                     HabboWebTools.openWebPage(var_3677 + var_790[_loc3_][0]);
                  }
                  return true;
               }
               _loc3_++;
            }
         }
         return false;
      }
      
      private function onBubbleMouseClick(param1:WindowMouseEvent) : void
      {
         if(var_790 && var_790.length > 0)
         {
            if(testMessageLinkMouseClick(param1.localX,param1.localY))
            {
               return;
            }
         }
         var_16.onItemMouseClick(var_1229,_senderName,var_2675,var_1951,param1);
      }
      
      private function onBubbleMouseDown(param1:WindowMouseEvent) : void
      {
         var_16.onItemMouseDown(var_1229,var_2675,var_1951,param1);
      }
      
      private function onBubbleMouseOver(param1:WindowMouseEvent) : void
      {
         var_16.onItemMouseOver(var_1229,var_2675,var_1951,param1);
      }
      
      private function onBubbleMouseOut(param1:WindowMouseEvent) : void
      {
         var_16.onItemMouseOut(var_1229,var_2675,var_1951,param1);
      }
      
      private function onBubbleMouseUp(param1:WindowMouseEvent) : void
      {
         var_16.mouseUp();
      }
      
      public function get chatStyle() : int
      {
         return var_1773;
      }
      
      public function get originalBackgroundYOffset() : Number
      {
         return _originalBackgroundYOffset;
      }
   }
}

