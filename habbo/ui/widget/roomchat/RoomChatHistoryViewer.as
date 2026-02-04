package com.sulake.habbo.ui.widget.roomchat
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IScrollableWindow;
   import com.sulake.core.window.components.IScrollbarWindow;
   import com.sulake.habbo.window.class_38;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class RoomChatHistoryViewer implements class_13
   {
      
      private static const CHAT_ITEM_HEIGHT:int = 18;
      
      private static const SCROLLBAR_WIDTH:int = 20;
      
      public static const MOUSE_HYSTERESIS_TOLERANCE:int = 3;
      
      private var _historyPulldown:RoomChatHistoryPulldown;
      
      private var _historyViewerActive:Boolean = false;
      
      private var _historyViewerDragStartY:Number = -1;
      
      private var var_98:IScrollbarWindow;
      
      private var var_626:Number = 1;
      
      private var var_2482:Boolean = false;
      
      private var var_16:RoomChatWidget;
      
      private var var_1134:Boolean = false;
      
      private var var_3498:Boolean = false;
      
      private var var_3012:Boolean = false;
      
      public function RoomChatHistoryViewer(param1:RoomChatWidget, param2:class_38, param3:class_1812, param4:class_40)
      {
         super();
         var_1134 = false;
         var_16 = param1;
         _historyPulldown = new RoomChatHistoryPulldown(param1,param2,param3,param4);
         _historyPulldown.state = 0;
         var _loc5_:IItemListWindow = param3.getChildByName("chat_contentlist") as IItemListWindow;
         if(_loc5_ == null)
         {
            return;
         }
         param3.removeChild(_loc5_);
         param3.addChild(_loc5_);
         var_98 = param2.createWindow("chatscroller","",131,0,0x10 | 0,new Rectangle(param3.right - 20,param3.y,20,param3.height - 39),null,0) as IScrollbarWindow;
         param3.addChild(var_98);
         var_98.visible = false;
         var_98.scrollable = _loc5_ as IScrollableWindow;
      }
      
      public function set disabled(param1:Boolean) : void
      {
         var_2482 = param1;
      }
      
      public function set visible(param1:Boolean) : void
      {
         if(_historyPulldown == null || var_2482)
         {
            return;
         }
         _historyPulldown.state = param1 ? 1 : 0;
      }
      
      public function get active() : Boolean
      {
         return _historyViewerActive;
      }
      
      public function get scrollbarWidth() : Number
      {
         return _historyViewerActive ? 20 : 0;
      }
      
      public function get pulldownBarHeight() : Number
      {
         return 39;
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      public function get visible() : Boolean
      {
         if(_historyPulldown == null)
         {
            return false;
         }
         return _historyPulldown.state == 1 || _historyPulldown.state == 2;
      }
      
      public function dispose() : void
      {
         hideHistoryViewer();
         if(var_98 != null)
         {
            var_98.dispose();
            var_98 = null;
         }
         if(_historyPulldown != null)
         {
            _historyPulldown.dispose();
            _historyPulldown = null;
         }
         var_1134 = true;
      }
      
      public function update(param1:uint) : void
      {
         if(_historyPulldown != null)
         {
            _historyPulldown.update(param1);
         }
         moveHistoryScroll();
      }
      
      public function toggleHistoryViewer() : void
      {
         if(_historyViewerActive)
         {
            hideHistoryViewer();
         }
         else
         {
            showHistoryViewer();
         }
      }
      
      public function hideHistoryViewer() : void
      {
         var_626 = 1;
         cancelDrag();
         _historyViewerActive = false;
         setHistoryViewerScrollbar(false);
         _historyPulldown.state = 0;
         if(var_16 != null)
         {
            var_16.resetArea();
            var_16.enableDragTooltips();
            var_16.handler.container.toolbar.extensionView.extraMargin = 0;
         }
      }
      
      public function showHistoryViewer() : void
      {
         if(!_historyViewerActive && !var_2482)
         {
            _historyViewerActive = true;
            setHistoryViewerScrollbar(true);
            _historyPulldown.state = 1;
            if(var_16 != null)
            {
               var_16.reAlignItemsToHistoryContent();
               var_16.disableDragTooltips();
            }
         }
      }
      
      private function setHistoryViewerScrollbar(param1:Boolean) : void
      {
         if(var_98 != null)
         {
            var_98.visible = param1;
            if(param1)
            {
               var_98.scrollV = 1;
               var_626 = 1;
            }
            else
            {
               _historyViewerActive = false;
               _historyViewerDragStartY = -1;
            }
         }
      }
      
      public function containerResized(param1:Rectangle, param2:Boolean = false) : void
      {
         if(var_98 != null)
         {
            var_98.x = param1.x + param1.width - var_98.width;
            var_98.y = param1.y;
            var_98.height = param1.height - 39;
            if(param2)
            {
               var_98.scrollV = var_626;
            }
         }
         if(_historyPulldown != null)
         {
            _historyPulldown.containerResized(param1);
         }
      }
      
      private function processDrag(param1:Number, param2:Boolean = false) : void
      {
         var _loc8_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc3_:int = 0;
         var _loc6_:Boolean = false;
         var _loc7_:Boolean = false;
         if(_historyViewerDragStartY > 0 && param2)
         {
            if(var_3012)
            {
               if(Math.abs(param1 - _historyViewerDragStartY) <= 3)
               {
                  return;
               }
               var_3012 = false;
            }
            if(!_historyViewerActive)
            {
               var_16.resizeContainerToLowestItem();
               showHistoryViewer();
               moveHistoryScroll();
            }
            if(_historyViewerActive)
            {
               var_16.handler.container.toolbar.extensionView.extraMargin = 20;
               moveHistoryScroll();
               _loc4_ = var_98.scrollable.scrollableRegion.height / var_98.scrollable.visibleRegion.height;
               _loc5_ = (param1 - _historyViewerDragStartY) / var_98.height;
               _loc8_ = var_626 - _loc5_ / _loc4_;
               _loc8_ = Math.max(0,_loc8_);
               _loc8_ = Math.min(1,_loc8_);
               _loc3_ = param1 - _historyViewerDragStartY;
               _loc6_ = true;
               _loc7_ = true;
               if(var_98.scrollV < 1 - 18 / var_98.scrollable.scrollableRegion.height)
               {
                  _loc7_ = false;
               }
               if(_loc7_ || var_3498)
               {
                  var_16.stretchAreaBottomBy(_loc3_);
                  _loc6_ = false;
                  var_626 = 1;
                  var_98.scrollV = 1;
               }
               if(_loc6_)
               {
                  var_626 = _loc8_;
               }
               _historyViewerDragStartY = param1;
            }
         }
         else
         {
            _historyViewerDragStartY = -1;
         }
      }
      
      public function beginDrag(param1:Number, param2:Boolean = false) : void
      {
         if(var_2482)
         {
            return;
         }
         _historyViewerDragStartY = param1;
         var_3498 = param2;
         var_3012 = true;
         if(var_98 != null)
         {
            var_626 = var_98.scrollV;
         }
         if(var_98 != null)
         {
            var _loc3_:DisplayObject = var_98.context.getDesktopWindow().getDisplayObject();
         }
      }
      
      public function cancelDrag() : void
      {
         _historyViewerDragStartY = -1;
         if(var_98 != null)
         {
            var _loc1_:DisplayObject = var_98.context.getDesktopWindow().getDisplayObject();
         }
      }
      
      private function moveHistoryScroll() : void
      {
         if(!_historyViewerActive)
         {
            return;
         }
         if(_historyViewerDragStartY < 0)
         {
            return;
         }
         if(var_3498)
         {
            return;
         }
         var _loc1_:Number = var_626 - var_98.scrollV;
         if(_loc1_ == 0)
         {
            return;
         }
         if(Math.abs(_loc1_) < 0.01)
         {
            var_98.scrollV = var_626;
         }
         else
         {
            var_98.scrollV += _loc1_ / 2;
         }
      }
      
      private function onStageMouseUp(param1:MouseEvent) : void
      {
         cancelDrag();
         if(var_16 != null)
         {
            var_16.mouseUp();
         }
      }
      
      private function onStageMouseMove(param1:MouseEvent) : void
      {
         processDrag(param1.stageY,param1.buttonDown);
      }
   }
}

