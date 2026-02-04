package com.sulake.habbo.freeflowchat.history.visualization
{
   import com.sulake.habbo.freeflowchat.HabboFreeFlowChat;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class ChatHistoryScrollBar
   {
      
      public static const RIGHT_MARGIN:int = 0;
      
      private var var_383:ChatHistoryScrollView;
      
      private var _displayObject:Sprite;
      
      private var _background:Sprite;
      
      private var var_688:Sprite;
      
      private var var_3641:int;
      
      private var var_4128:int;
      
      private var var_513:Stage;
      
      public function ChatHistoryScrollBar(param1:ChatHistoryScrollView, param2:HabboFreeFlowChat)
      {
         super();
         var_383 = param1;
         var_688 = HabboFreeFlowChat.create9SliceSprite(new Rectangle(2,2,1,1),param2.assets.getAssetByName("scrollbar_thumb").content as BitmapData);
         var_688.x = 2;
         var_688.y = 2;
         _background = HabboFreeFlowChat.create9SliceSprite(new Rectangle(2,2,5,5),param2.assets.getAssetByName("scrollbar_back").content as BitmapData);
         _displayObject = new Sprite();
         _displayObject.addChild(_background);
         _displayObject.addChild(var_688);
         var_688.addEventListener("addedToStage",onAddedToStage);
         var_688.addEventListener("removedFromStage",onRemovedFromStage);
         var_688.addEventListener("mouseDown",mouseDownEventHandler);
      }
      
      public function set height(param1:int) : void
      {
         _background.height = param1;
         updateThumbTrack();
      }
      
      public function get displayObject() : Sprite
      {
         return _displayObject;
      }
      
      public function updateThumbTrack() : void
      {
         var _loc1_:int = var_383.topY + (var_383.viewPort.height - _background.height);
         var_688.height = Math.min(_background.height - 4,Math.max(5,int((_background.height - 4) * (_background.height / var_383.bufferHeight))));
         var_688.y = Math.min(_background.height - 2 - var_688.height,Math.max(2,int((_background.height - 4) * (Math.max(1,_loc1_) / var_383.bufferHeight) - var_688.height / 2)));
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         var_513 = var_688.stage;
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
         var_513 = null;
      }
      
      private function mouseDownEventHandler(param1:Event) : void
      {
         var_3641 = MouseEvent(param1).stageY;
         var_4128 = var_383.topY;
         var_513.addEventListener("mouseUp",mouseDragEventHandler);
         var_513.addEventListener("mouseMove",mouseDragEventHandler);
         param1.stopImmediatePropagation();
      }
      
      private function mouseDragEventHandler(param1:Event) : void
      {
         var _loc4_:Number = NaN;
         var _loc2_:int = 0;
         var _loc3_:MouseEvent = MouseEvent(param1);
         switch(_loc3_.type)
         {
            case "mouseMove":
               _loc4_ = var_383.bufferHeight / _background.height;
               _loc2_ = (_loc3_.stageY - var_3641) * _loc4_;
               var_383.topY = var_4128 + _loc2_;
               break;
            case "mouseUp":
               endScroll();
         }
         param1.stopImmediatePropagation();
      }
      
      public function endScroll() : void
      {
         if(var_513)
         {
            var_513.removeEventListener("mouseUp",mouseDragEventHandler);
            var_513.removeEventListener("mouseMove",mouseDragEventHandler);
         }
      }
   }
}

