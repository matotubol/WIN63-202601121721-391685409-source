package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IIconWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.components.class_1993;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.class_1750;
   import com.sulake.habbo.catalog.recycler.FurniSlotItem;
   import com.sulake.habbo.catalog.recycler.IRecycler;
   import com.sulake.habbo.catalog.recycler.IRecyclerVisualization;
   import com.sulake.habbo.catalog.viewer.CatalogObjectMover;
   import com.sulake.habbo.catalog.viewer.widgets.franksemotions.FrankRecyclerEmotion;
   import com.sulake.habbo.catalog.viewer.widgets.utils.RecyclerEngineAnimator;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.ISelectedRoomObjectData;
   import com.sulake.habbo.room.class_1829;
   import com.sulake.habbo.room.class_2198;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   
   public class RecyclerCatalogWidget extends CatalogWidget implements class_2612, IRecyclerVisualization, class_1829
   {
      
      private var var_392:CatalogObjectMover;
      
      private var var_889:Dictionary;
      
      private var var_1234:RecyclerEngineAnimator;
      
      private var var_832:Timer;
      
      public function RecyclerCatalogWidget(param1:class_1812)
      {
         super(param1);
      }
      
      private function get recycler() : IRecycler
      {
         return page.viewer.catalog.getRecycler();
      }
      
      override public function dispose() : void
      {
         if(var_392 != null)
         {
            var_392.dispose();
            var_392 = null;
         }
         if(recycler != null)
         {
            recycler.cancel();
         }
         if(var_1234 != null)
         {
            var_1234.dispose();
            var_1234 = null;
         }
         if(var_832 != null)
         {
            stopTimer();
         }
         super.dispose();
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         attachWidgetView("recyclerWidget");
         renderSlotGraphics();
         renderDucketCost();
         var _loc2_:class_1741 = window.findChildByName("recycler_recycle");
         _loc2_.addEventListener("WME_CLICK",onRecycleButtonClick);
         var _loc1_:class_1741 = window.findChildByName("abort_region");
         _loc1_.addEventListener("WME_CLICK",onAbortClick);
         patFrankButton.addEventListener("WME_CLICK",onPatFrank);
         abortButtonVisible = false;
         var_1234 = new RecyclerEngineAnimator(window.findChildByName("pointer_arrow") as IStaticBitmapWrapperWindow,window.parent.findChildByName("recycle_machine") as IStaticBitmapWrapperWindow,onAnimationComplete);
         if(recycler == null)
         {
            return false;
         }
         recycler.init(this);
         return true;
      }
      
      private function onPatFrank(param1:WindowMouseEvent) : void
      {
         var _loc2_:FrankRecyclerEmotion = new FrankRecyclerEmotion(emoji2BitmapTemplate);
         _loc2_.start(disabledBorder);
      }
      
      public function updateUI() : void
      {
         var _loc1_:class_1741 = window;
         while(_loc1_ != null)
         {
            _loc1_.procedure = onMainContainerEvent;
            _loc1_.mouseThreshold = 0;
            _loc1_ = _loc1_.parent;
         }
         var _loc2_:class_1741 = (window.parent as class_1812).findChildByName("catalog.header.description");
         if(_loc2_ != null)
         {
            _loc2_.caption = "${recycler.info.ready}";
         }
         disabledBorder.visible = recycler.recyclerDisabled;
         updateRecycleButton();
      }
      
      private function startTimer() : void
      {
         var_832 = new Timer(1000);
         var_832.addEventListener("timer",onTimerTick);
         var_832.start();
      }
      
      private function stopTimer() : void
      {
         if(var_832)
         {
            var_832.stop();
            var_832.removeEventListener("timer",onTimerTick);
            var_832 = null;
         }
      }
      
      private function onTimerTick(param1:TimerEvent) : void
      {
         updateRecycleButton();
         if(recycler.secondsToWait() <= 0)
         {
            stopTimer();
         }
      }
      
      private function renderSlotGraphics() : void
      {
         var _loc3_:int = 0;
         var _loc1_:class_2251 = null;
         var _loc2_:BitmapData = getAssetBitmapData("ctlg_recycler_slot_bg");
         if(_loc2_ == null)
         {
            return;
         }
         _loc3_ = 1;
         while(_loc3_ <= recycler.numberOfSlots)
         {
            _loc1_ = window.findChildByName("slot_bg_" + _loc3_) as class_2251;
            if(_loc1_ != null)
            {
               _loc1_.bitmap = _loc2_.clone();
               _loc1_.procedure = onSlotMouseEvent;
               _loc1_.mouseThreshold = 0;
            }
            _loc3_++;
         }
         _loc3_ = 1;
         while(_loc3_ <= recycler.numberOfSlots)
         {
            _loc1_ = window.findChildByName("slot_img_" + _loc3_) as class_2251;
            if(_loc1_ != null)
            {
               _loc1_.bitmap = _loc2_.clone();
               _loc1_.procedure = onSlotMouseEvent;
               _loc1_.mouseThreshold = 0;
            }
            _loc3_++;
         }
      }
      
      private function renderDucketCost() : void
      {
         if(window == null || recycler == null)
         {
            return;
         }
         var _loc1_:ITextWindow = window.findChildByName("ducket_cost") as ITextWindow;
         var _loc3_:IIconWindow = window.findChildByName("ducket_icon") as IIconWindow;
         var _loc2_:int = recycler.ducketCost;
         if(_loc2_ == 0)
         {
            _loc1_.visible = false;
            _loc3_.visible = false;
         }
         else
         {
            _loc1_.visible = true;
            _loc3_.visible = true;
            _loc1_.text = String(_loc2_);
         }
      }
      
      public function updateSlots() : void
      {
         if(window == null || recycler == null)
         {
            return;
         }
         var_889 = new Dictionary();
         var _loc4_:int = 0;
         if(0 >= recycler.numberOfSlots)
         {
            return;
         }
         var _loc3_:class_2251 = window.findChildByName("slot_img_" + (0 + 1)) as class_2251;
      }
      
      private function updateImage(param1:BitmapData, param2:class_2251) : void
      {
         var _loc4_:BitmapData = new BitmapData(param2.width,param2.height,true,16777215);
         _loc4_.fillRect(_loc4_.rect,16777215);
         var _loc3_:Point = new Point((param2.width - param1.width) / 2,(param2.height - param1.height) / 2);
         _loc4_.copyPixels(param1,param1.rect,_loc3_,null,null,true);
         param2.bitmap = _loc4_;
         param1.dispose();
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         var _loc4_:int = 0;
         var _loc3_:class_2251 = null;
         if(var_889 != null && param1 in var_889)
         {
            _loc4_ = int(var_889[param1]);
            delete var_889[param1];
            _loc3_ = window.findChildByName("slot_img_" + (_loc4_ + 1)) as class_2251;
            if(_loc3_ == null)
            {
               return;
            }
            updateImage(param2,_loc3_);
         }
      }
      
      public function imageFailed(param1:int) : void
      {
         if(var_889 != null)
         {
            delete var_889[param1];
         }
      }
      
      private function getFurniImageResult(param1:FurniSlotItem) : class_2198
      {
         if(param1 == null || page.viewer.roomEngine == null)
         {
            return null;
         }
         if(param1.category == 10)
         {
            return page.viewer.roomEngine.getFurnitureIcon(param1.typeId,this);
         }
         if(param1.category == 20)
         {
            return page.viewer.roomEngine.getWallItemIcon(param1.typeId,this,param1.xxxExtra);
         }
         return null;
      }
      
      private function get easterEggMode() : Boolean
      {
         if(recycler == null)
         {
            return false;
         }
         var_889 = new Dictionary();
         var _loc2_:int = 0;
         while(0 < recycler.numberOfSlots)
         {
            var _loc1_:FurniSlotItem = recycler.getSlotContent(0);
            if(page.viewer.roomEngine.getFurnitureType(null.typeId) == "wf_act_reset_timers")
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      private function onMainContainerEvent(param1:class_1758, param2:class_1741) : void
      {
         if(page == null || page.viewer == null)
         {
            return;
         }
         var _loc5_:IRoomEngine = page.viewer.roomEngine;
         if(_loc5_ == null)
         {
            return;
         }
         var _loc4_:ISelectedRoomObjectData = _loc5_.getSelectedObjectData(_loc5_.activeRoomId);
         switch(param1.type)
         {
            case "WME_OUT":
               if(var_392 != null)
               {
                  var_392.onMainContainerEvent(param1,param2,_loc4_);
               }
               break;
            case "WME_MOVE":
               if(var_392 != null)
               {
                  var_392.onMainContainerEvent(param1,param2,_loc4_);
               }
               break;
            case "WME_OVER":
               if(var_392 == null)
               {
                  var_392 = new CatalogObjectMover();
                  var_392.mainContainer = window;
                  var_392.roomEngine = _loc5_;
               }
         }
         var _loc3_:Boolean = var_392 != null && var_392.state;
         if(_loc3_ && _loc5_.getObjectMoverIconSpriteVisible())
         {
            _loc5_.setObjectMoverIconSpriteVisible(false);
         }
      }
      
      private function onSlotMouseEvent(param1:class_1758, param2:class_1741) : void
      {
         var objectData:ISelectedRoomObjectData;
         var slotId:int;
         var event:class_1758 = param1;
         var target:class_1741 = param2;
         var roomEngine:IRoomEngine = page.viewer.roomEngine;
         if(roomEngine == null || recycler == null)
         {
            return;
         }
         objectData = roomEngine.getSelectedObjectData(roomEngine.activeRoomId);
         if(event.type == "WME_UP")
         {
            if(event.window.name.indexOf("slot_") == 0)
            {
               slotId = int(event.window.name.charAt(event.window.name.length - 1)) - 1;
               if(objectData != null)
               {
                  if(objectData.operation != "OBJECT_PLACE")
                  {
                     page.viewer.catalog.windowManager.alert("${generic.alert.title}","${catalog.alert.recycler.inventory}",0,function(param1:class_1750, param2:class_1758):void
                     {
                        param1.dispose();
                     });
                     return;
                  }
                  recycler.placeObjectAtSlot(slotId,objectData.id,objectData.category,objectData.typeId,objectData.instanceData);
               }
               else
               {
                  recycler.releaseSlot(slotId);
               }
               roomEngine.cancelRoomObjectInsert();
               if(var_392 != null)
               {
                  var_392.resetIcon();
               }
               return;
            }
         }
         if(event.type == "WME_MOVE")
         {
            onMainContainerEvent(event,target);
         }
      }
      
      public function updateRecycleButton() : void
      {
         var _loc2_:int = 0;
         if(disposed || window == null)
         {
            return;
         }
         var _loc1_:class_1741 = window.findChildByName("recycler_recycle");
         if(_loc1_ != null)
         {
            _loc2_ = recycler.secondsToWait();
            if(_loc2_ > 0)
            {
               _loc1_.caption = page.viewer.catalog.localization.getLocalizationWithParams("catalog.recycler.button.wait","","s",_loc2_);
            }
            else
            {
               _loc1_.caption = "${catalog.recycler.button.recycle}";
            }
            if(recycler.isReadyToRecycle() && !var_1234.isBusy() && _loc2_ <= 0)
            {
               _loc1_.enable();
            }
            else
            {
               _loc1_.disable();
            }
            if(var_832 == null && recycler.secondsToWait() > 0)
            {
               startTimer();
            }
         }
      }
      
      private function onRecycleButtonClick(param1:WindowMouseEvent) : void
      {
         var event:WindowMouseEvent = param1;
         if(!recycler.hasEnoughDuckets())
         {
            page.viewer.catalog.windowManager.alert("${generic.alert.title}","${catalog.alert.notenough.activitypoints.title.0}",0,function(param1:class_1750, param2:class_1758):void
            {
               param1.dispose();
            });
            return;
         }
         var_1234.start(easterEggMode);
         updateRecycleButton();
         abortButtonVisible = true;
      }
      
      private function onAbortClick(param1:WindowMouseEvent) : void
      {
         abortButtonVisible = false;
         var_1234.stop();
         updateRecycleButton();
         setTimeout(resetAnimation,650);
      }
      
      private function onAnimationComplete() : void
      {
         if(recycler != null)
         {
            recycler.executeRecycler();
            recycler.setNextRecycleAllowedTimestamp(getTimer() + recycler.timeout * 1000);
         }
         updateRecycleButton();
         setTimeout(resetAnimation,1000);
         abortButtonVisible = false;
      }
      
      private function resetAnimation() : void
      {
         var_1234.reset();
      }
      
      private function set abortButtonVisible(param1:Boolean) : void
      {
         var _loc2_:class_1741 = window.findChildByName("abort_region");
         _loc2_.visible = param1;
      }
      
      private function get disabledBorder() : class_1993
      {
         return window.findChildByName("disabled_border") as class_1993;
      }
      
      private function get patFrankButton() : class_1775
      {
         return window.findChildByName("pat_frank_btn") as class_1775;
      }
      
      private function get emoji1Bitmap() : IStaticBitmapWrapperWindow
      {
         return window.findChildByName("emoji_1") as IStaticBitmapWrapperWindow;
      }
      
      private function get emoji2BitmapTemplate() : IStaticBitmapWrapperWindow
      {
         return window.findChildByName("emoji_2_template") as IStaticBitmapWrapperWindow;
      }
   }
}

