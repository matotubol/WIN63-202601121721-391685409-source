package com.sulake.habbo.friendbar.landingview.layout
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IScrollbarWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.class_1758;
   import flash.geom.Rectangle;
   
   public class DynamicLayoutManager implements class_13
   {
      
      public static const PLACEHOLDER_NAME:String = "placeholder_dynamic_widget_slots";
      
      public static const CONTENT_AREA_START_X:int = 230;
      
      private static const NUMBER_OF_SLOTS:int = 5;
      
      private static const RESIZE_TOLERANCE_SCROLLBAR_VISIBILITY:int = 6;
      
      private static const ABSOLUTE_MINIMUM_HEIGHT:int = 360;
      
      private var _layout:WidgetContainerLayout;
      
      private var var_198:IItemListWindow;
      
      private var var_1392:IItemListWindow;
      
      private var var_575:IItemListWindow;
      
      private var var_2899:class_1812;
      
      private var var_662:IItemListWindow;
      
      private var var_2827:class_1812;
      
      private var var_122:Vector.<class_1812> = new Vector.<class_1812>(5);
      
      private var var_3486:IItemListWindow;
      
      private var var_3404:IItemListWindow;
      
      private var var_2244:class_1812;
      
      private var var_4821:class_1741;
      
      private var _fromTopScrollbar:IScrollbarWindow;
      
      private var _window:class_1812;
      
      private var var_4499:Boolean = false;
      
      private var var_1318:CommonWidgetSettings;
      
      private var var_2451:int = 10;
      
      private var var_2064:int = 50;
      
      private var var_2598:int = 10;
      
      private var var_5266:int = 80;
      
      private var var_5200:int = 10;
      
      private var var_3585:int = 60;
      
      private var var_3672:int = -1;
      
      private var _topItemListInitialWidth:int = -1;
      
      private var var_704:Boolean = false;
      
      private var var_2829:class_1741 = null;
      
      public function DynamicLayoutManager(param1:WidgetContainerLayout, param2:CommonWidgetSettings)
      {
         super();
         _layout = param1;
         var_1318 = param2;
         _window = class_1812(_layout.landingView.getXmlWindow("dynamic_widget_grid"));
         var _loc6_:class_1741 = _layout.window.findChildByName("placeholder_dynamic_widget_slots");
         var _loc3_:class_1812 = class_1812(_loc6_.parent);
         _loc3_.addChildAt(_window,_loc3_.getChildIndex(_loc6_));
         _loc3_.removeChild(_loc6_);
         var_198 = IItemListWindow(_window.findChildByName("widgetlist_fromtop"));
         var_2899 = class_1812(_window.findChildByName("center_slots_container"));
         var_1392 = IItemListWindow(_window.findChildByName("widget_slots_center_scrollable"));
         var_575 = IItemListWindow(_window.findChildByName("widget_slots_center_left"));
         var_662 = IItemListWindow(_window.findChildByName("widget_slots_center_right"));
         var_2827 = class_1812(_window.findChildByName("widget_slots_right"));
         var_3486 = IItemListWindow(_window.findChildByName("widget_slot_4_root"));
         var_3404 = IItemListWindow(_window.findChildByName("widget_slot_5_root"));
         var_4821 = _layout.landingView.getXmlWindow("dynamic_widget_grid_separator");
         var _loc5_:int = 0;
         while(true)
         {
            var_122[0] = class_1812(_window.findChildByName("widget_slot_" + (0 + 1)));
            if(var_122[0] != null)
            {
               var_122[0].addEventListener("WE_RESIZED",contractCenterContainer);
            }
            _loc5_++;
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         if(!disposed)
         {
            _loc1_ = 0;
            while(_loc1_ < 6)
            {
               if(var_122[_loc1_])
               {
                  var_122[_loc1_].dispose();
               }
               var_122[_loc1_] = null;
               _loc1_++;
            }
            if(_window)
            {
               _window.dispose();
               _window = null;
            }
            _layout = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _layout == null;
      }
      
      public function getDynamicSlotContainer(param1:int) : class_1812
      {
         return var_122[param1];
      }
      
      public function enableSeparator(param1:int, param2:String) : void
      {
         var _loc3_:IItemListWindow = null;
         var _loc4_:ITextWindow = null;
         switch(param1 - 4)
         {
            case 0:
               _loc3_ = var_3486;
               break;
            case 1:
               _loc3_ = var_3404;
               break;
            default:
               _loc3_ = null;
         }
         if(_loc3_)
         {
            if(_loc3_.numListItems < 2)
            {
               _loc3_.addListItemAt(var_4821.clone(),0);
            }
            _loc4_ = ITextWindow(IItemListWindow(_loc3_.getListItemAt(0)).getListItemByName("separator_title"));
            _loc4_.caption = "${" + param2 + "}";
            if(var_1318 != null)
            {
               if(var_1318.isTextColorSet)
               {
                  _loc4_.textColor = var_1318.textColor;
               }
               if(var_1318.isEtchingColorSet)
               {
                  _loc4_.etchingColor = var_1318.etchingColor;
               }
               if(var_1318.isEtchingPositionSet)
               {
                  _loc4_.etchingPosition = var_1318.etchingPosition;
               }
            }
         }
      }
      
      private function isSlotOccupied(param1:int) : Boolean
      {
         return var_122[param1].numChildren > 0;
      }
      
      public function resizeTo(param1:int, param2:int) : void
      {
         var_198.height = Math.min(param2,topItemListInitialHeight);
         var_198.height = Math.max(360,var_198.height);
         var_198.width = Math.min(param1,topItemListInitialWidth);
         applyVerticalSize();
      }
      
      public function set scrollbarRightEdgeRelativeToScreen(param1:int) : void
      {
         var _loc2_:int = int(_layout.window.width);
         param1 = Math.min(param1,_loc2_) - _window.x;
         _fromTopScrollbar.x = param1 - _fromTopScrollbar.width;
      }
      
      public function get topItemListInitialHeight() : int
      {
         if(var_3672 == -1)
         {
            var_3672 = var_198.height;
         }
         return var_3672;
      }
      
      public function get topItemListInitialWidth() : int
      {
         if(_topItemListInitialWidth == -1)
         {
            _topItemListInitialWidth = var_198.width;
         }
         return _topItemListInitialWidth;
      }
      
      private function applyVerticalSize() : void
      {
         var _loc1_:int = 0;
         clearEmptySlotsForSpace();
         alignTopWidgetRow();
         alignBottomWidgetRow();
         resetToMaximumSpacing();
         setVerticalSpacing(topItemListContentHeight - var_198.height);
         contractCenterContainer();
         adjustScrollbarVisibility();
         setHorizontalSpacing();
         if(!var_704)
         {
            _loc1_ = 0;
            while(_loc1_ < 6)
            {
               if(var_122[_loc1_] != null)
               {
                  var_122[_loc1_].addEventListener("WE_RESIZED",updateLayout);
               }
               _loc1_++;
            }
         }
         var_704 = true;
         var_2829 = null;
      }
      
      private function updateLayout(param1:class_1758 = null) : void
      {
         if(var_2829 == null)
         {
            var_2829 = param1.window;
            applyVerticalSize();
         }
      }
      
      private function clearEmptySlotsForSpace() : void
      {
         var _loc1_:int = 0;
         if(!isSlotOccupied(0))
         {
            var_122[0].height = 0;
         }
         _loc1_ = 1;
         while(_loc1_ <= 4)
         {
            if(!isSlotOccupied(_loc1_))
            {
               var_122[_loc1_].height = 1;
            }
            _loc1_++;
         }
      }
      
      private function alignBottomWidgetRow() : void
      {
         var _loc1_:int = 0;
         if(isSlotOccupied(3) || isSlotOccupied(4))
         {
            _loc1_ = Math.max(var_122[3].height,var_122[4].height);
            var_122[3].height = _loc1_;
            var_122[4].height = _loc1_;
            if(isSlotOccupied(3))
            {
               var_122[3].getChildAt(0).y = 0;
               var_122[3].width = _layout.landingView.dynamicLayoutLeftPaneWidth;
            }
            if(isSlotOccupied(4))
            {
               var_122[4].getChildAt(0).y = 0;
               var_122[4].width = _layout.landingView.dynamicLayoutRightPaneWidth;
            }
         }
      }
      
      private function alignTopWidgetRow() : int
      {
         var _loc1_:int = 0;
         if(isSlotOccupied(1) || isSlotOccupied(2))
         {
            if(!var_4499)
            {
               _loc1_ = Math.max(var_122[1].height,var_122[2].height);
               var_122[1].height = _loc1_;
               var_122[2].height = _loc1_;
            }
            if(isSlotOccupied(1))
            {
               var_122[1].getChildAt(0).y = 0;
               var_122[1].width = _layout.landingView.dynamicLayoutLeftPaneWidth;
            }
            if(isSlotOccupied(2))
            {
               var_122[2].getChildAt(0).y = 0;
               var_122[2].width = _layout.landingView.dynamicLayoutRightPaneWidth;
            }
         }
         return _loc1_;
      }
      
      private function setHorizontalSpacing() : void
      {
         var _loc1_:int = _topItemListInitialWidth - var_198.width;
         if(_loc1_ > var_3585 - var_5200)
         {
            var_1392.spacing = var_5200;
         }
         else
         {
            var_1392.spacing = Math.min(var_3585,var_3585 - _loc1_);
         }
      }
      
      private function setVerticalSpacing(param1:int) : void
      {
         var _loc2_:int = var_2064 - var_2451;
         var _loc3_:int = var_5266 - var_2598;
         param1 += var_2451 + var_2598;
         if(param1 <= 0)
         {
            var_198.spacing = var_2598;
            var_575.spacing = var_2064;
            var_662.spacing = var_2064;
         }
         else if(param1 < _loc2_)
         {
            var_198.spacing = var_2598;
            var_575.spacing = var_2064 - param1;
            var_662.spacing = var_2064 - param1;
         }
         else if(param1 < _loc2_ + _loc3_)
         {
            var_198.spacing = var_2598;
            var_575.spacing = var_2451;
            var_662.spacing = var_2451;
         }
         else
         {
            var_198.spacing = var_2598;
            var_575.spacing = var_2451;
            var_662.spacing = var_2451;
         }
      }
      
      private function adjustScrollbarVisibility() : void
      {
         var_198.invalidate();
         if(var_198.height < topItemListContentHeight - 6)
         {
            _fromTopScrollbar.y = var_198.y;
            _fromTopScrollbar.height = var_198.height;
            _fromTopScrollbar.visible = true;
            _fromTopScrollbar.scrollV = 0;
            var_2244.y = topItemListContentHeight;
            var_2244.height = 25;
            _layout.landingView.toolbarExtensionExtraMargin = true;
         }
         else
         {
            var_2244.y = 0;
            var_2244.height = 1;
            _layout.landingView.toolbarExtensionExtraMargin = false;
         }
      }
      
      private function resetToMaximumSpacing() : void
      {
         var_1392.spacing = var_3585;
         var_575.spacing = var_2064;
         var_662.spacing = var_2064;
         var_198.spacing = var_5266;
         _fromTopScrollbar.visible = false;
         var_575.invalidate();
         var_662.invalidate();
         var_1392.invalidate();
         var_198.invalidate();
         var_2899.invalidate();
      }
      
      private function get topItemListContentHeight() : int
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < var_198.numListItems)
         {
            _loc2_ = var_198.getListItemAt(_loc3_).height;
            _loc1_ += _loc2_;
            if(_loc3_ > 0)
            {
               _loc1_ += var_198.spacing;
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      private function contractCenterContainer(param1:class_1758 = null) : void
      {
         if(param1 != null && !var_704)
         {
            return;
         }
         var_575.invalidate();
         var_662.invalidate();
         var_1392.height = Math.max(var_575.height,var_662.height);
         var_2899.height = Math.max(var_575.height,var_662.height);
      }
      
      public function set ignoreBottomRightSlot(param1:Boolean) : void
      {
         var_4499 = param1;
      }
      
      private function logFinalPositions() : void
      {
         var _loc2_:int = 0;
         class_21.log("***** Final positions *****");
         var _loc1_:Rectangle = new Rectangle();
         _window.getGlobalRectangle(_loc1_);
         class_21.log("Window rect\t\t\t\t\t\t: " + _loc1_);
         var_198.getGlobalRectangle(_loc1_);
         class_21.log("All items list rect\t\t\t\t: " + _loc1_);
         var_2899.getGlobalRectangle(_loc1_);
         class_21.log("Center container itemlist rect\t: " + _loc1_);
         var_1392.getGlobalRectangle(_loc1_);
         class_21.log("Center itemlist rect\t\t\t: " + _loc1_);
         var_575.getGlobalRectangle(_loc1_);
         class_21.log("Left pane itemlist rect\t\t\t: " + _loc1_);
         var_662.getGlobalRectangle(_loc1_);
         class_21.log("Right pane itemlist rect\t\t: " + _loc1_);
         var_2827.getGlobalRectangle(_loc1_);
         class_21.log("Right pane container rect\t\t: " + _loc1_);
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            var_122[_loc2_].getGlobalRectangle(_loc1_);
            class_21.log("Slot " + _loc2_ + " rect\t\t\t    : " + _loc1_);
            _loc2_++;
         }
      }
   }
}

