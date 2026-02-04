package com.sulake.habbo.freeflowchat.viewer.visualization
{
   import com.sulake.habbo.freeflowchat.HabboFreeFlowChat;
   import com.sulake.habbo.freeflowchat.data.ChatItem;
   import com.sulake.habbo.freeflowchat.viewer.enum.ChatBubbleWidth;
   import com.sulake.habbo.freeflowchat.viewer.visualization.style.class_2134;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   
   public class PooledChatBubble extends Sprite
   {
      
      public static const MAX_WIDTH_DEFAULT:uint = 300;
      
      private static const DESKTOP_MARGIN_LEFT:int = 85;
      
      private static const DESKTOP_MARGIN_RIGHT:int = 190;
      
      private static const LINEAR_INTERPOLATION_MS:uint = 150;
      
      private static const MAX_HEIGHT:uint = 108;
      
      private static const const_214:int = 28;
      
      private static const POINTER_DEFAULT_MARGIN_RIGHT:int = 15;
      
      private static const POINTER_REPOSITION_INTERVAL_MS:int = 2000;
      
      private static const ZERO_POINT:Point = new Point(0,0);
      
      private var var_59:HabboFreeFlowChat;
      
      private var var_405:ChatItem;
      
      private var _background:Sprite;
      
      private var var_595:Bitmap;
      
      private var var_664:Bitmap;
      
      private var var_1276:BitmapData;
      
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
      
      private var var_3315:uint = 0;
      
      private var var_515:int = -1;
      
      public function PooledChatBubble(param1:HabboFreeFlowChat)
      {
         super();
         var_59 = param1;
         var_595 = new Bitmap();
         var_664 = new Bitmap();
         var_76 = new TextField();
         var_740 = new Sprite();
         this.addEventListener("addedToStage",onAddedToStage);
         this.addEventListener("removedFromStage",onRemovedFromStage);
      }
      
      public function set chatItem(param1:ChatItem) : void
      {
         var_405 = param1;
      }
      
      public function set face(param1:BitmapData) : void
      {
         var_1276 = param1;
      }
      
      public function set style(param1:class_2134) : void
      {
         _style = param1;
      }
      
      public function recreate(param1:String, param2:uint, param3:Boolean = false, param4:int = -1) : void
      {
         _background = _style.getNewBackgroundSprite(param2);
         var_595.bitmapData = _style.pointer;
         var_3853 = param3;
         var _loc11_:int = int(var_59.roomChatSettings ? ChatBubbleWidth.accordingToRoomChatSetting(var_59.roomChatSettings.bubbleWidth) : 300);
         var _loc9_:int = _loc11_ - _style.textFieldMargins.x - _style.textFieldMargins.width;
         var_76.width = _loc9_;
         var_76.multiline = true;
         var_76.wordWrap = true;
         var_76.selectable = false;
         var_76.thickness = -15;
         var_76.sharpness = 80;
         var_76.antiAliasType = "advanced";
         var_76.embedFonts = true;
         var_76.gridFitType = "pixel";
         var_76.cacheAsBitmap = !_style.allowHTML;
         var_76.styleSheet = null;
         var_76.defaultTextFormat = _style.textFormat;
         var_76.styleSheet = _style.styleSheet;
         var_76.addEventListener("link",onTextLinkEvent);
         var _loc7_:* = var_405.chatType == 0;
         var _loc6_:* = var_405.chatType == 2;
         var _loc13_:Boolean = !_loc7_ && !_loc6_ && !_style.isAnonymous;
         if(_loc13_)
         {
            var_76.alpha = 0.6;
         }
         else
         {
            var_76.alpha = 1;
         }
         var _loc18_:String = (_loc13_ ? "<i>" : "") + (_style.isAnonymous ? "" : "<b>" + param1 + ": </b>");
         _loc18_ = _loc18_ + (_loc6_ ? "<b>" : "") + var_405.text + (_loc6_ ? "</b>" : "");
         _loc18_ = _loc18_ + (_loc13_ ? "</i>" : "");
         if(var_405.links == null || var_405.links[0] == null)
         {
            var_76.htmlText = _loc18_;
         }
         else
         {
            var _loc14_:int = -1;
            var _loc16_:Array = [];
            var _loc10_:int = 0;
            while(0 < var_405.links.length)
            {
               var _loc15_:String = var_405.links[0][0][1];
               var _loc19_:String = "<a href=\"" + null + "\">" + null + "</a>";
               var _loc20_:String = "{" + 0 + "}";
               var _loc8_:int = int(var_405.text.indexOf(null));
               _loc14_ = _loc8_ + null.length;
               null.push([0,0]);
               _loc18_ = _loc18_.replace(null,null);
               _loc10_++;
            }
            var_76.htmlText = _loc18_;
         }
         var_515 = param4;
         var _loc17_:int = Math.min(_loc11_,var_76.textWidth + _style.textFieldMargins.x + _style.textFieldMargins.width);
         var _loc5_:int = var_76.textHeight + _style.textFieldMargins.y + _style.textFieldMargins.height;
         if(!_style.isSystemStyle)
         {
            _loc5_ = Math.min(108,_loc5_);
         }
         if(param4 != -1)
         {
            _loc5_ = Math.max(param4,_loc5_);
         }
         _loc17_ = Math.max(_loc17_,_background.width);
         _loc5_ = Math.max(_loc5_,_background.height);
         _background.width = _loc17_;
         _background.height = _loc5_;
         _background.x = 0;
         _background.y = 0;
         _background.cacheAsBitmap = true;
         addChild(_background);
         if(!_style.isAnonymous)
         {
            var_595.x = Math.max(_style.getPointerLeftMargin(28),Math.min(_style.getPointerRightMargin(15),userRelativePosX));
            var_595.y = _loc5_ - _style.pointerOffsetToBubbleBottom;
            addChild(var_595);
         }
         if(var_1276 != null && _style.faceOffset != null)
         {
            if(var_1276.height > _loc5_)
            {
               var _loc12_:BitmapData = new BitmapData(var_1276.width,_loc5_);
               _loc12_.copyPixels(var_1276,new Rectangle(0,var_1276.height - _loc5_,var_1276.width,_loc5_),new Point(0,0));
            }
            else
            {
               _loc12_ = var_1276;
            }
            var_664.bitmapData = null;
            var_664.x = _style.faceOffset.x - null.width / 2;
            var_664.y = Math.max(1,_style.faceOffset.y - null.height / 2);
            addChild(var_664);
         }
         var_76.width = Math.min(_loc9_,var_76.textWidth + _style.textFieldMargins.width);
         var_76.height = var_76.textHeight + _style.textFieldMargins.height;
         var_76.x = _style.textFieldMargins.x;
         var_76.y = _style.textFieldMargins.y;
         addChild(var_76);
         if(!_style.isSystemStyle && var_76.textHeight > 108)
         {
            var_740.graphics.clear();
            var_740.graphics.beginFill(16777215);
            var_740.graphics.drawRect(0,0,var_76.textWidth + 5,108 - _style.textFieldMargins.height);
            var_740.graphics.endFill();
            var_76.mask = var_740;
            addChild(var_740);
            var_740.x = var_76.x;
            var_740.y = var_76.y;
         }
         else
         {
            var_740.graphics.clear();
            var_76.mask = null;
         }
         if(_style.isNotification && var_664 != null)
         {
            var_664.y = Math.max(1,height / 2 - null.height / 2);
            var_664.x -= 0.5;
         }
         this.cacheAsBitmap = !_style.allowHTML;
         var_2838 = false;
         var_1171 = 0;
         var_3315 = 0;
         visible = false;
      }
      
      public function unregister() : void
      {
         this.cacheAsBitmap = false;
         this.removeEventListener("click",onMouseClick);
         if(var_740.parent == this)
         {
            safelyRemoveChild(var_740);
         }
         safelyRemoveChild(var_76);
         if(_style.faceOffset != null && var_664.parent == this)
         {
            safelyRemoveChild(var_664);
            var_664.bitmapData = null;
         }
         if(var_595 && var_595.parent)
         {
            safelyRemoveChild(var_595);
         }
         safelyRemoveChild(_background);
         if(var_76)
         {
            var_76.removeEventListener("link",onTextLinkEvent);
         }
      }
      
      private function onTextLinkEvent(param1:TextEvent) : void
      {
         var _loc7_:String = null;
         var _loc4_:String = null;
         var _loc3_:TextField = null;
         var _loc2_:Point = null;
         var _loc5_:Rectangle = null;
         var _loc6_:String = null;
         if(param1.text && param1.text.length > 0)
         {
            _loc7_ = param1.text;
            _loc4_ = "highlight/";
            if(_loc7_.indexOf(_loc4_) > -1)
            {
               _loc3_ = param1.target as TextField;
               _loc2_ = new Point(_loc3_.mouseX,_loc3_.mouseY);
               _loc2_ = _loc3_.localToGlobal(_loc2_);
               _loc5_ = new Rectangle(_loc2_.x,_loc2_.y);
               _loc6_ = _loc7_.substr(_loc7_.indexOf(_loc4_) + _loc4_.length,_loc7_.length);
               var_59.windowManager.hideHint();
               var_59.windowManager.showHint(_loc6_.toLocaleUpperCase(),_loc5_);
            }
            else
            {
               var_59.context.createLinkEvent(param1.text);
            }
         }
      }
      
      private function safelyRemoveChild(param1:DisplayObject) : void
      {
         try
         {
            removeChild(param1);
         }
         catch(error:ArgumentError)
         {
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
      
      private function onRemovedFromStage(param1:Event) : void
      {
         this.removeEventListener("click",onMouseClick);
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
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:* = 0;
         var_1171 += param1;
         if(proxyX != var_1507 || y != var_1680)
         {
            _loc2_ = var_1171 - var_3992;
            if(_loc2_ < 150 && _loc2_ > 0)
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
         if(var_1171 > var_3315 + 2000)
         {
            repositionPointer();
            var_3315 = var_1171;
         }
         if(var_1171 > 150 && !visible)
         {
            visible = true;
         }
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
      
      public function get minHeight() : int
      {
         return var_515;
      }
   }
}

