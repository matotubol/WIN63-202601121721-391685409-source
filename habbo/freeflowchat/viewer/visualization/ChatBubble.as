package com.sulake.habbo.freeflowchat.viewer.visualization
{
   import com.sulake.habbo.freeflowchat.HabboFreeFlowChat;
   import com.sulake.habbo.freeflowchat.data.ChatItem;
   import com.sulake.habbo.freeflowchat.viewer.enum.ChatBubbleWidth;
   import com.sulake.habbo.freeflowchat.viewer.visualization.style.class_2134;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   
   public class ChatBubble extends Sprite
   {
      
      public static const MAX_WIDTH_DEFAULT:uint = 300;
      
      public static const const_1071:int = 15;
      
      private static const DESKTOP_MARGIN_LEFT:int = 85;
      
      private static const DESKTOP_MARGIN_RIGHT:int = 190;
      
      private static const LINEAR_INTERPOLATION_MS:uint = 150;
      
      private static const MAX_HEIGHT:uint = 108;
      
      private static const const_214:int = 28;
      
      private static const POINTER_DEFAULT_MARGIN_RIGHT:int = 15;
      
      private static const ZERO_POINT:Point = new Point(0,0);
      
      private var var_59:HabboFreeFlowChat;
      
      private var var_405:ChatItem;
      
      private var _background:Sprite;
      
      private var var_595:Bitmap;
      
      private var var_664:Bitmap;
      
      private var var_76:TextField;
      
      private var _style:class_2134;
      
      private var var_1171:uint = 0;
      
      private var var_3992:uint;
      
      private var var_1507:int;
      
      private var var_1680:int;
      
      private var var_4932:int;
      
      private var var_4103:int;
      
      private var var_3820:Number;
      
      private var var_3897:Number;
      
      private var var_2838:Boolean = false;
      
      private var var_2703:int = 0;
      
      private var var_2935:int;
      
      private var var_3853:Boolean = false;
      
      private var _hasHitDesktopMargin:Boolean = false;
      
      private var var_740:Sprite;
      
      public function ChatBubble(param1:ChatItem, param2:class_2134, param3:BitmapData, param4:String, param5:uint, param6:HabboFreeFlowChat, param7:int = -1, param8:Boolean = false, param9:int = -1)
      {
         super();
         var_59 = param6;
         var_405 = param1;
         _style = param2;
         _background = param2.getNewBackgroundSprite(param5);
         var_595 = param2.isAnonymous ? null : new Bitmap(param2.pointer);
         var_3853 = param8;
         var _loc22_:int = 300;
         if(param7 != -1)
         {
            _loc22_ = ChatBubbleWidth.accordingToRoomChatSetting(param7);
         }
         else if(param6.roomChatSettings)
         {
            _loc22_ = ChatBubbleWidth.accordingToRoomChatSetting(param6.roomChatSettings.bubbleWidth);
         }
         _loc22_ -= 15;
         this.cacheAsBitmap = true;
         var _loc12_:int = _loc22_ - param2.textFieldMargins.x - param2.textFieldMargins.width;
         var_76 = new TextField();
         var_76.width = _loc12_;
         var_76.multiline = true;
         var_76.wordWrap = true;
         var_76.selectable = false;
         var_76.thickness = -15;
         var_76.sharpness = 80;
         var_76.antiAliasType = "advanced";
         var_76.embedFonts = true;
         var_76.gridFitType = "pixel";
         var_76.cacheAsBitmap = true;
         var_76.defaultTextFormat = param2.textFormat;
         var_76.styleSheet = _style.styleSheet;
         var_76.addEventListener("link",onTextLinkEvent);
         var _loc11_:* = param1.chatType == 0;
         var _loc19_:* = param1.chatType == 2;
         var _loc13_:Boolean = !_loc11_ && !_loc19_ && !_style.isAnonymous;
         if(_loc13_)
         {
            var_76.alpha = 0.6;
         }
         var _loc16_:String = (_loc13_ ? "<i>" : "") + (_style.isAnonymous ? "" : "<b>" + param4 + ": </b>");
         _loc16_ = _loc16_ + (_loc19_ ? "<b>" : "") + param1.text + (_loc19_ ? "</b>" : "");
         _loc16_ = _loc16_ + (_loc13_ ? "</i>" : "");
         if(param1.links == null || param1.links[0] == null)
         {
            var_76.htmlText = _loc16_;
         }
         else
         {
            var _loc24_:int = -1;
            var _loc25_:Array = [];
            var _loc21_:int = 0;
            while(0 < param1.links.length)
            {
               var _loc14_:String = param1.links[0][0][1];
               var _loc17_:String = "<a href=\"" + null + "\">" + null + "</a>";
               var _loc18_:String = "{" + 0 + "}";
               var _loc20_:int = int(param1.text.indexOf(null));
               _loc24_ = _loc20_ + null.length;
               null.push([0,0]);
               _loc16_ = _loc16_.replace(null,null);
               _loc21_++;
            }
            var_76.htmlText = _loc16_;
         }
         var _loc15_:int = Math.min(_loc22_,var_76.textWidth + param2.textFieldMargins.x + param2.textFieldMargins.width);
         var _loc10_:int = var_76.textHeight + param2.textFieldMargins.y + param2.textFieldMargins.height;
         if(!_style.isSystemStyle)
         {
            _loc10_ = Math.min(108,_loc10_);
         }
         if(param9 != -1)
         {
            _loc10_ = Math.max(param9,_loc10_);
         }
         _loc15_ = Math.max(_loc15_,_background.width);
         _loc10_ = Math.max(_loc10_,_background.height);
         _background.width = _loc15_;
         _background.height = _loc10_;
         _background.x = 0;
         _background.y = 0;
         _background.cacheAsBitmap = true;
         addChild(_background);
         if(!_style.isAnonymous)
         {
            var_595.x = Math.max(param2.getPointerLeftMargin(28),Math.min(param2.getPointerRightMargin(15),userRelativePosX));
            var_595.y = _loc10_ - param2.pointerOffsetToBubbleBottom;
            addChild(var_595);
         }
         if(param3 != null && param2.faceOffset != null)
         {
            if(param3.height > _loc10_)
            {
               var _loc23_:BitmapData = new BitmapData(param3.width,_loc10_);
               _loc23_.copyPixels(param3,new Rectangle(0,param3.height - _loc10_,param3.width,_loc10_),new Point(0,0));
            }
            else
            {
               _loc23_ = param3;
            }
            var_664 = new Bitmap(null);
            var_664.x = param2.faceOffset.x - null.width / 2;
            var_664.y = Math.max(1,param2.faceOffset.y - null.height / 2);
            addChild(var_664);
         }
         var_76.width = Math.min(_loc12_,var_76.textWidth + _style.textFieldMargins.width);
         var_76.height = var_76.textHeight + _style.textFieldMargins.height;
         var_76.x = param2.textFieldMargins.x;
         var_76.y = param2.textFieldMargins.y;
         addChild(var_76);
         if(_style.isNotification && var_664 != null)
         {
            var_664.y = Math.max(1,height / 2 - null.height / 2);
         }
         if(!_style.isSystemStyle && var_76.textHeight > 108)
         {
            var_740 = new Sprite();
            var_740.graphics.clear();
            var_740.graphics.beginFill(16777215);
            var_740.graphics.drawRect(0,0,var_76.textWidth + 5,108 - param2.textFieldMargins.height);
            var_76.mask = var_740;
            addChild(var_740);
         }
         this.addEventListener("addedToStage",onAddedToStage);
      }
      
      public function dispose() : void
      {
         this.removeEventListener("addedToStage",onAddedToStage);
         this.removeEventListener("click",onMouseClick);
         if(var_740)
         {
            removeChild(var_740);
         }
         if(var_76)
         {
            var_76.removeEventListener("link",onTextLinkEvent);
         }
         removeChild(var_76);
         if(var_664 != null && _style.faceOffset != null)
         {
            removeChild(var_664);
         }
         if(var_595 && var_595.parent)
         {
            removeChild(var_595);
         }
         removeChild(_background);
         var_740 = null;
         var_76 = null;
         var_664 = null;
         var_595 = null;
         _background = null;
         _style = null;
      }
      
      private function onTextLinkEvent(param1:TextEvent) : void
      {
         if(param1.text && param1.text.length > 0)
         {
            var_59.context.createLinkEvent(param1.text);
         }
      }
      
      public function get displayedHeight() : Number
      {
         return _style.isSystemStyle ? height : Math.min(108,height);
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         this.addEventListener("click",onMouseClick);
      }
      
      public function moveTo(param1:int, param2:int) : void
      {
         if(var_1507 != param1 || var_1680 != param2)
         {
            var_3992 = var_1171;
            var_4932 = proxyX;
            var_4103 = y;
            var_1507 = param1;
            var_1680 = param2;
            var_3820 = (param1 - proxyX) / 150;
            var_3897 = (param2 - y) / 150;
         }
      }
      
      public function warpTo(param1:int, param2:int) : void
      {
         var_1507 = param1;
         var_1680 = param2;
         proxyX = param1;
         y = param2;
         repositionPointer();
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:* = 0;
         var_1171 += param1;
         if(proxyX != var_1507 || y != var_1680)
         {
            _loc2_ = var_1171 - var_3992;
            if(_loc2_ < 150)
            {
               proxyX = var_4932 + _loc2_ * var_3820;
               y = int(var_4103 + _loc2_ * var_3897);
            }
            else
            {
               proxyX = var_1507;
               y = var_1680;
            }
         }
         repositionPointer();
      }
      
      public function get proxyX() : int
      {
         return var_2935;
      }
      
      public function set proxyX(param1:int) : void
      {
         var_2935 = param1;
         if(var_3853 && stage)
         {
            var _loc2_:int = var_2935 + var_2703;
            _hasHitDesktopMargin = false;
            var _loc3_:int = stage.stageWidth - 190 - width;
            _loc2_ = 85;
            _hasHitDesktopMargin = true;
            x = 0;
         }
         else
         {
            x = var_2935 + var_2703;
         }
      }
      
      public function repositionPointer() : void
      {
         if(var_595 && var_595.parent)
         {
            var_595.x = Math.max(_style.getPointerLeftMargin(28),Math.min(_background.width - _style.getPointerRightMargin(15),userRelativePosX));
            var_595.y = _background.height - _style.pointerOffsetToBubbleBottom;
         }
      }
      
      public function get readyToRecycle() : Boolean
      {
         return var_2838;
      }
      
      public function set readyToRecycle(param1:Boolean) : void
      {
         var_2838 = param1;
         if(param1)
         {
            this.removeEventListener("click",onMouseClick);
         }
      }
      
      public function get timeStamp() : uint
      {
         return var_405.timeStamp;
      }
      
      public function set component(param1:HabboFreeFlowChat) : void
      {
         var_59 = param1;
      }
      
      private function get userRelativePosX() : int
      {
         return userScreenPos.x - this.x;
      }
      
      public function get userScreenPos() : Point
      {
         if(var_405.forcedScreenLocation)
         {
            if(var_59.displayObject.stage == null)
            {
               return ZERO_POINT;
            }
            return new Point(var_59.displayObject.stage.stageWidth / 2 + var_405.forcedScreenLocation,500);
         }
         return var_59.getScreenPointFromRoomLocation(var_405.roomId,var_405.userLocation);
      }
      
      public function get roomId() : int
      {
         return var_405.roomId;
      }
      
      public function set roomPanOffsetX(param1:int) : void
      {
         if(var_2703 != param1)
         {
            var_2703 = param1;
            warpTo(var_1507,var_1680);
         }
      }
      
      private function onMouseClick(param1:MouseEvent) : void
      {
         if(_style && _style.isAnonymous)
         {
            return;
         }
         if(!var_59.clickHasToPropagate(param1))
         {
            var_59.selectAvatarWithChatItem(var_405);
            param1.stopImmediatePropagation();
         }
      }
      
      public function get overlap() : Rectangle
      {
         return _style.overlap;
      }
      
      public function get hasHitDesktopMargin() : Boolean
      {
         return _hasHitDesktopMargin;
      }
      
      public function drawToBitmap(param1:BitmapData) : void
      {
         param1.draw(this);
      }
   }
}

