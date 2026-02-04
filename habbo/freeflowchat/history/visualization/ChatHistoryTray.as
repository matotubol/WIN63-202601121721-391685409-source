package com.sulake.habbo.freeflowchat.history.visualization
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.runtime.class_31;
   import com.sulake.habbo.freeflowchat.HabboFreeFlowChat;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class ChatHistoryTray implements class_13, class_31
   {
      
      private var _rootDisplayObject:DisplayObjectContainer;
      
      private var var_513:Stage;
      
      private var var_59:HabboFreeFlowChat;
      
      private var var_383:ChatHistoryScrollView;
      
      private var _tab:Sprite;
      
      private var var_448:Bitmap;
      
      private var var_203:Bitmap;
      
      private var _bg:Bitmap;
      
      private var _openedWidth:int;
      
      private var _flagUpdateDisableRoomMouseEvents:Boolean = false;
      
      public function ChatHistoryTray(param1:HabboFreeFlowChat, param2:ChatHistoryScrollView)
      {
         super();
         var_59 = param1;
         var_383 = param2;
         _rootDisplayObject = new Sprite();
         var_448 = new Bitmap();
         var_448.bitmapData = BitmapData(var_59.assets.getAssetByName("tray_bar").content);
         var_448.width = var_448.bitmapData.width;
         var_448.height = 0;
         var_448.scaleX = 1;
         var_448.x = -var_448.bitmapData.width;
         var_203 = new Bitmap();
         var_203.bitmapData = BitmapData(var_59.assets.getAssetByName("tray_handle_open").content);
         var_203.scaleX = 1;
         var_203.scaleY = 1;
         var_203.x = -0;
         var_203.y = 350;
         var_203.visible = false;
         _tab = new Sprite();
         _tab.scaleX = 1;
         _tab.scaleY = 1;
         _tab.visible = true;
         _tab.addChild(var_448);
         _tab.addChild(var_203);
         _rootDisplayObject.addChild(_tab);
         _bg = new Bitmap();
         _bg.bitmapData = new BitmapData(1,1,true,2720277278);
         _bg.width = 0;
         _bg.height = 0;
         _rootDisplayObject.addChild(_bg);
         _rootDisplayObject.addEventListener("addedToStage",onAddedToStage);
         _openedWidth = 350 + 62 + 1;
      }
      
      public function dispose() : void
      {
         var_59.disableRoomMouseEventsLeftOfX(0);
         if(_rootDisplayObject)
         {
            var_383.deactivateScrolling();
            if(var_513)
            {
               var_513.removeEventListener("mouseDown",stageMouseClickedEventHandler);
            }
         }
         _rootDisplayObject = null;
      }
      
      public function get disposed() : Boolean
      {
         return _rootDisplayObject == null;
      }
      
      public function get rootDisplayObject() : DisplayObjectContainer
      {
         return _rootDisplayObject;
      }
      
      public function resize(param1:int, param2:int) : void
      {
         _tab.height = param2 - 50;
         var_448.height = param2 - 50;
         _bg.height = param2 - 50;
         _tab.scaleY = 1;
         var_203.scaleY = 1;
         var_203.y = param2 - 215;
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         resize(_rootDisplayObject.stage.stageWidth,_rootDisplayObject.stage.stageHeight);
         _rootDisplayObject.stage.addEventListener("click",stageMouseClickedEventHandler);
         var_513 = _rootDisplayObject.stage;
      }
      
      public function toggleHistoryVisibility() : void
      {
         if(var_383.isActive)
         {
            var_383.deactivateScrolling();
            _rootDisplayObject.removeChild(var_383.rootDisplayObject);
            var_383.deactivateView();
            _bg.width = 0;
            var_448.x = -var_448.bitmapData.width;
            var_203.x = -0;
            var_203.visible = false;
            var_383.viewWidth = 0;
            var_203.bitmapData = BitmapData(var_59.assets.getAssetByName("tray_handle_open").content);
         }
         else
         {
            _rootDisplayObject.addChild(var_383.rootDisplayObject);
            var_383.scrollToBottom();
            var_383.activateScrolling();
            var_383.activateView();
            _bg.width = _openedWidth;
            var_448.x = _openedWidth;
            var_203.visible = true;
            var_203.x = _openedWidth - 0 + var_448.bitmapData.width;
            var_383.viewWidth = _openedWidth;
            var_203.bitmapData = BitmapData(var_59.assets.getAssetByName("tray_handle_close").content);
         }
         _flagUpdateDisableRoomMouseEvents = true;
      }
      
      public function set visible(param1:Boolean) : void
      {
         if(var_383.isActive && !param1 || !var_383.isActive && param1)
         {
            toggleHistoryVisibility();
         }
      }
      
      private function stageMouseClickedEventHandler(param1:Event) : void
      {
         if(!_rootDisplayObject || !_rootDisplayObject.stage)
         {
            return;
         }
         var _loc2_:MouseEvent = MouseEvent(param1);
         if(var_383.isActive && var_203.x <= _loc2_.stageX && _loc2_.stageX <= var_203.x + var_203.width && var_203.y <= _loc2_.stageY && _loc2_.stageY <= var_203.y + var_203.height)
         {
            toggleHistoryVisibility();
         }
      }
      
      public function update(param1:uint) : void
      {
         if(_flagUpdateDisableRoomMouseEvents && param1 > 20)
         {
            var_59.disableRoomMouseEventsLeftOfX(!var_383.isActive ? 0 : _openedWidth + var_448.bitmapData.width);
            _flagUpdateDisableRoomMouseEvents = false;
         }
      }
   }
}

