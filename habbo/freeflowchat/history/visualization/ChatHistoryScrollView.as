package com.sulake.habbo.freeflowchat.history.visualization
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.class_2001;
   import com.sulake.habbo.freeflowchat.HabboFreeFlowChat;
   import com.sulake.habbo.freeflowchat.history.*;
   import com.sulake.habbo.freeflowchat.history.visualization.entry.class_2434;
   import com.sulake.habbo.freeflowchat.history.visualization.entry.class_2441;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class ChatHistoryScrollView implements class_13
   {
      
      private var var_59:HabboFreeFlowChat;
      
      private var _historyBuffer:ChatHistoryBuffer;
      
      private var _rootDisplayObject:DisplayObjectContainer;
      
      private var var_513:Stage;
      
      private var var_299:Vector.<class_2441>;
      
      private var var_2295:int = 0;
      
      private var var_1976:Rectangle;
      
      private var _visibleWidth:int = 0;
      
      private var var_3641:int;
      
      private var var_5072:int;
      
      private var var_740:Sprite;
      
      private var var_1037:Boolean = false;
      
      private var _scrollBar:ChatHistoryScrollBar;
      
      private var _ignore:Bitmap;
      
      private var var_219:class_2441;
      
      public function ChatHistoryScrollView(param1:HabboFreeFlowChat, param2:ChatHistoryBuffer)
      {
         super();
         var_59 = param1;
         _historyBuffer = param2;
         _rootDisplayObject = new Sprite();
         _rootDisplayObject.x = 0;
         _rootDisplayObject.y = 0;
         _rootDisplayObject.addEventListener("addedToStage",onAddedToStage);
         _scrollBar = new ChatHistoryScrollBar(this,param1);
         _ignore = new Bitmap();
         _ignore.bitmapData = BitmapData(var_59.assets.getAssetByName("close_x").content);
         var_219 = null;
      }
      
      public function dispose() : void
      {
         deactivateScrolling();
         deactivateView();
         var_740 = null;
         _ignore = null;
         var_219 = null;
         if(_rootDisplayObject)
         {
            _rootDisplayObject.removeEventListener("addedToStage",onAddedToStage);
            _rootDisplayObject = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return var_740 == null && _rootDisplayObject == null;
      }
      
      public function get rootDisplayObject() : DisplayObjectContainer
      {
         return _rootDisplayObject;
      }
      
      public function activateView() : void
      {
         if(!_historyBuffer)
         {
            return;
         }
         deactivateView();
         var_299 = new Vector.<class_2441>(_historyBuffer.entries.length);
         var _loc4_:int = 0;
         var _loc3_:int = -var_2295;
         while(0 < _historyBuffer.entries.length)
         {
            var _loc2_:class_2441 = new class_2441();
            var _loc1_:class_2434 = _historyBuffer.entries[0];
            null.roomId = null.roomId;
            null.userId = null.userId;
            null.bitmapData = null.bitmap;
            null.canIgnore = null.canIgnore;
            null.userName = null.userName;
            _loc3_ = 0 - null.overlap.y;
            null.y = 0;
            null.x = 3;
            _loc3_ = 0 + null.bitmapData.height;
            _loc3_ = 0 - 8;
            var_299[0] = null;
            _rootDisplayObject.addChild(var_299[0]);
            _loc4_++;
         }
         _rootDisplayObject.addChild(_scrollBar.displayObject);
         var_1037 = true;
      }
      
      public function deactivateView() : void
      {
         if(disposed)
         {
            return;
         }
         for each(var _loc1_ in var_299)
         {
            _rootDisplayObject.removeChild(_loc1_);
            _loc1_.bitmapData = null;
         }
         if(var_219 != null)
         {
            _rootDisplayObject.removeChild(_ignore);
            var_219 = null;
         }
         var_299 = new Vector.<class_2441>(0);
         if(_scrollBar.displayObject != null && _scrollBar.displayObject.parent == _rootDisplayObject)
         {
            _rootDisplayObject.removeChild(_scrollBar.displayObject);
         }
         var_1037 = false;
      }
      
      public function activateScrolling() : void
      {
         deactivateScrolling();
         _rootDisplayObject.stage.addEventListener("mouseDown",mouseDragEventHandler);
         var_513 = _rootDisplayObject.stage;
         var_513.addEventListener("resize",onStageResized);
      }
      
      public function deactivateScrolling() : void
      {
         if(var_513)
         {
            var_513.removeEventListener("mouseDown",mouseDragEventHandler);
            var_513.removeEventListener("mouseMove",mouseDragEventHandler,true);
            var_513.removeEventListener("mouseUp",mouseDragEventHandler);
            var_513.removeEventListener("resize",onStageResized);
         }
      }
      
      public function get topY() : int
      {
         return var_2295;
      }
      
      public function get bufferHeight() : int
      {
         return _historyBuffer.totalHeight;
      }
      
      public function set topY(param1:int) : void
      {
         var_2295 = param1;
         if(var_299)
         {
            var _loc4_:int = 0;
            var _loc3_:int = -var_2295;
            while(0 < _historyBuffer.entries.length)
            {
               if(var_299.length <= 0)
               {
                  break;
               }
               var _loc2_:class_2434 = _historyBuffer.entries[0];
               _loc3_ = 0 - null.overlap.y;
               var_299[0].y = 0;
               _loc3_ = 0 + (null.bitmap.height - 8);
               _loc4_++;
            }
         }
         if(var_219 != null)
         {
            _ignore.y = var_219.y + (var_219.height - _ignore.height) / 2;
         }
         _scrollBar.updateThumbTrack();
      }
      
      public function addHistoryEntry(param1:class_2434) : void
      {
         var _loc2_:class_2441 = new class_2441();
         _loc2_.bitmapData = param1.bitmap;
         _loc2_.y = -var_2295 + _historyBuffer.totalHeight - param1.bitmap.height + 8;
         _loc2_.x = 3;
         _loc2_.userId = param1.userId;
         _loc2_.roomId = param1.roomId;
         _loc2_.canIgnore = param1.canIgnore;
         _loc2_.userName = param1.userName;
         var_299.push(_loc2_);
         _rootDisplayObject.addChild(var_299[var_299.length - 1]);
      }
      
      public function scrollUpAndSpliceTopItem(param1:int) : void
      {
         if(var_299 && var_299.length > 0)
         {
            _rootDisplayObject.removeChild(var_299[0]);
            var_299.splice(0,1);
            for each(var _loc2_ in var_299)
            {
               _loc2_.y -= param1;
            }
         }
      }
      
      public function get viewPort() : Rectangle
      {
         return var_1976;
      }
      
      public function set viewPort(param1:Rectangle) : void
      {
         var_1976 = param1;
         _rootDisplayObject.width = param1.width;
         _rootDisplayObject.height = param1.height;
         _rootDisplayObject.scaleX = 1;
         _rootDisplayObject.scaleY = 1;
         if(!var_740)
         {
            var_740 = new Sprite();
            _rootDisplayObject.addChild(var_740);
         }
         var_740.graphics.clear();
         var_740.graphics.beginFill(16777215);
         var_740.graphics.drawRect(0,0,viewPort.width,viewPort.height);
         _rootDisplayObject.mask = var_740;
         _scrollBar.displayObject.x = var_1976.width - 0;
         viewBottom = param1.height;
      }
      
      public function set viewBottom(param1:int) : void
      {
         _rootDisplayObject.y = param1 - var_1976.height;
         _scrollBar.height = param1;
         _scrollBar.displayObject.y = var_1976.height - param1;
      }
      
      public function set viewWidth(param1:int) : void
      {
         _visibleWidth = param1;
         _scrollBar.displayObject.x = _visibleWidth - 0;
      }
      
      public function scrollToBottom() : void
      {
         topY = _historyBuffer.totalHeight - viewPort.height + 100;
      }
      
      public function get isActive() : Boolean
      {
         return var_1037;
      }
      
      private function findSpriteAtY(param1:int) : class_2441
      {
         for each(var _loc2_ in var_299)
         {
            if(param1 >= _loc2_.y && param1 <= _loc2_.y + _loc2_.height)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function mouseDragEventHandler(param1:Event) : void
      {
         if(!_rootDisplayObject || !_rootDisplayObject.stage)
         {
            return;
         }
         var _loc2_:MouseEvent = MouseEvent(param1);
         switch(_loc2_.type)
         {
            case "mouseDown":
               if(_loc2_.stageY < _rootDisplayObject.y + var_1976.height && _loc2_.stageX < _scrollBar.displayObject.x)
               {
                  _scrollBar.endScroll();
                  var_3641 = _loc2_.stageY;
                  var_5072 = topY;
                  var_513.addEventListener("mouseMove",mouseDragEventHandler,true);
                  var_513.addEventListener("mouseUp",mouseDragEventHandler);
               }
               break;
            case "mouseMove":
               var _loc5_:int = _loc2_.stageY - var_3641;
               topY = var_5072 - 0;
               param1.stopImmediatePropagation();
               break;
            case "mouseUp":
               var_513.removeEventListener("mouseMove",mouseDragEventHandler,true);
               var_513.removeEventListener("mouseUp",mouseDragEventHandler);
               var _loc4_:int = _loc2_.stageY - var_3641;
               if(_loc4_ < 1 && 0 > -1)
               {
                  if(!hitIgnore(_loc2_.stageX,_loc2_.stageY))
                  {
                     var _loc3_:class_2441 = findSpriteAtY(_loc2_.stageY);
                  }
               }
         }
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         var _loc2_:Stage = _rootDisplayObject.stage;
         viewPort = new Rectangle(0,0,_loc2_.stageWidth,_loc2_.stageHeight - 50);
      }
      
      private function onStageResized(param1:Event) : void
      {
         if(var_513)
         {
            viewPort = new Rectangle(0,0,var_513.stageWidth,var_513.stageHeight - 50);
         }
      }
      
      private function onEntrySpriteClicked(param1:class_2441) : void
      {
         if(!var_59)
         {
            return;
         }
         var_59.selectAvatar(param1.roomId,param1.userId);
      }
      
      private function moveIgnore(param1:class_2441) : void
      {
         if(!var_59 || param1 == var_219)
         {
            return;
         }
         if(!param1.canIgnore || var_59.sessionDataManager.isIgnored(param1.userId))
         {
            if(var_219 != null)
            {
               _rootDisplayObject.removeChild(_ignore);
               var_219 = null;
            }
            return;
         }
         _ignore.x = param1.x + param1.width + 5;
         _ignore.y = param1.y + (param1.height - _ignore.height) / 2;
         _rootDisplayObject.addChild(_ignore);
         var_219 = param1;
      }
      
      private function hitIgnore(param1:int, param2:int) : Boolean
      {
         if(var_219 == null || param1 < _ignore.x || param1 > _ignore.x + _ignore.width || param2 < _ignore.y || param2 > _ignore.y + _ignore.height)
         {
            return false;
         }
         var_59.localizations.registerParameter("chat.ignore_user.confirm.info","username",var_219.userName);
         var _loc4_:String = var_59.localizations.getLocalization("chat.ignore_user.confirm.title");
         var _loc3_:String = var_59.localizations.getLocalization("chat.ignore_user.confirm.info");
         var_59.windowManager.confirmWithModal(_loc4_,_loc3_,0,ignoreConfirmDialogEventProcessor);
         return true;
      }
      
      private function ignoreConfirmDialogEventProcessor(param1:class_2001, param2:class_1758) : void
      {
         param1.dispose();
         if(param2.type == "WE_OK")
         {
            var_59.sessionDataManager.ignoreUser(var_219.userId);
         }
         if(var_219 != null)
         {
            _rootDisplayObject.removeChild(_ignore);
            var_219 = null;
         }
      }
   }
}

