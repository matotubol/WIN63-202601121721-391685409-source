package com.sulake.habbo.window.utils.tableview
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1993;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class TableCellView implements class_13
   {
      
      private var _disposed:Boolean = false;
      
      private var var_647:TableView;
      
      private var var_1074:TableRowView;
      
      private var var_2031:String;
      
      private var var_87:TableCell;
      
      private var _container:IRegionWindow;
      
      private var _transitionTimer:Timer;
      
      public function TableCellView(param1:TableView, param2:TableRowView, param3:String, param4:TableCell)
      {
         super();
         var_647 = param1;
         var_1074 = param2;
         var_2031 = param3;
         var_87 = param4;
         _container = template.clone() as IRegionWindow;
         updateWidth();
         initializeView();
         _container.addEventListener("WME_DOUBLE_CLICK",onDoubleClick);
         _container.addEventListener("WME_DOWN",param2.onDown);
         _container.addEventListener("WME_OVER",param2.onHoverOver);
         _container.addEventListener("WME_OUT",param2.onHoverOut);
         _container.addEventListener("WME_CLICK_AWAY",param2.onClickAway);
         _container.mouseThreshold = 0;
      }
      
      private static function easeInOutCubic(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         var _loc5_:Number = param1 / param4;
         var _loc6_:Number = -(_loc5_ * 1.75 - 0.7) * (_loc5_ * 1.75 - 0.7) + 1;
         return param2 + param3 * _loc6_;
      }
      
      public function reuse(param1:TableCell) : void
      {
         var_87 = param1;
         initializeView();
      }
      
      public function update(param1:TableCell) : void
      {
         var_87 = param1;
         var _loc2_:ITextFieldWindow = getInputElement(false);
         if(_loc2_ != null && Boolean(_loc2_.visible))
         {
            updateContents();
         }
         else
         {
            initializeView();
            if(param1.highlightOnChange)
            {
               highlight();
            }
         }
      }
      
      private function setAllInvisible() : void
      {
         var _loc3_:ITextWindow = getTextElement(false);
         var _loc4_:ITextFieldWindow = getInputElement(false);
         var _loc2_:IRegionWindow = getLinkRegion(false);
         var _loc1_:IRegionWindow = getExtraButtonRegion(false);
         turnInvisible(_loc3_);
         turnInvisible(_loc4_);
         turnInvisible(_loc2_);
         turnInvisible(_loc1_);
      }
      
      private function turnInvisible(param1:class_1741) : void
      {
         if(param1 != null)
         {
            param1.visible = false;
         }
      }
      
      private function onLinkClick(param1:WindowMouseEvent) : void
      {
         if(var_87 != null && var_87.linkClickCallback != null)
         {
            var_87.linkClickCallback();
         }
      }
      
      private function onExtraButtonClick(param1:WindowMouseEvent) : void
      {
         if(var_87 != null && var_87.extraBtnCallback != null)
         {
            var_87.extraBtnCallback();
         }
      }
      
      private function initializeView() : void
      {
         setAllInvisible();
         if(var_87.type == TableCell.var_2973)
         {
            getLinkRegion(true).visible = true;
         }
         else if(var_87.type == TableCell.var_101)
         {
            getTextElement(true).visible = true;
         }
         updateContents();
      }
      
      private function updateContents() : void
      {
         var _loc3_:ITextWindow = null;
         if(var_87.type == TableCell.var_2973)
         {
            getLinkElement(true).text = var_87.contents as String;
         }
         else if(var_87.type == TableCell.var_101)
         {
            _loc3_ = getTextElement(true);
            _loc3_.textColor = var_87.textColor;
            _loc3_.autoSize = column.alignment;
            _loc3_.text = var_87.contents as String;
         }
         var _loc2_:String = "";
         if(var_87.tooltipText != null)
         {
            _loc2_ = var_87.tooltipText;
         }
         else if(var_87.type == TableCell.var_101 && _loc3_ != null && _loc3_.isOverflown)
         {
            _loc2_ = var_87.contents as String;
         }
         _container.toolTipCaption = _loc2_;
         var _loc1_:IRegionWindow = getExtraButtonRegion(false);
         if(var_87.extraBtn != null)
         {
            _loc1_ = getExtraButtonRegion(true);
            _loc1_.visible = true;
            getExtraButton(true).assetUri = var_87.extraBtn;
            _loc1_.interactiveCursorDisabled = var_87.extraBtnCallback == null;
         }
         else if(_loc1_ != null)
         {
            _loc1_.visible = false;
         }
      }
      
      private function get column() : TableColumn
      {
         return var_647.getColumnById(var_2031);
      }
      
      public function updateWidth() : void
      {
         _container.width = var_647.getCellWidth(var_2031);
      }
      
      public function get container() : class_1812
      {
         return _container;
      }
      
      private function onInputEdit(param1:class_1758) : void
      {
         var _loc2_:WindowKeyboardEvent = param1 as WindowKeyboardEvent;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:ITextFieldWindow = getInputElement(false);
         if(_loc2_.keyCode == 13 && var_87.isEditable)
         {
            var_647.onEnterNewCellValue(_loc3_.text,var_1074.object,var_2031);
            initializeView();
         }
         else if(_loc2_.keyCode == 27)
         {
            initializeView();
         }
      }
      
      private function onInputFocusOut(param1:class_1758) : void
      {
         initializeView();
      }
      
      private function onDoubleClick(param1:WindowMouseEvent) : void
      {
         var _loc2_:ITextFieldWindow = null;
         if(var_87.isInspectable || var_87.isEditable)
         {
            setAllInvisible();
            _loc2_ = getInputElement(true);
            _loc2_.visible = true;
            _loc2_.text = var_87.textFieldValue;
            _loc2_.editable = var_87.isEditable;
            _loc2_.focus();
         }
      }
      
      public function recycle() : void
      {
         var_87 = null;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _container.dispose();
         var_2031 = null;
         var_647 = null;
         _container = null;
         var_87 = null;
         _disposed = true;
         if(_transitionTimer != null)
         {
            _transitionTimer.reset();
            _transitionTimer = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function getTextElement(param1:Boolean) : ITextWindow
      {
         var _loc2_:ITextWindow = _container.findChildByName("element_text") as ITextWindow;
         if(_loc2_ == null && param1)
         {
            return template.createElementText(_container) as ITextWindow;
         }
         return _loc2_;
      }
      
      private function getInputElement(param1:Boolean) : ITextFieldWindow
      {
         var _loc3_:ITextFieldWindow = null;
         var _loc2_:ITextFieldWindow = _container.findChildByName("element_input") as ITextFieldWindow;
         if(_loc2_ == null && param1)
         {
            _loc3_ = template.createElementInput(_container) as ITextFieldWindow;
            _loc3_.addEventListener("WKE_KEY_DOWN",onInputEdit);
            _loc3_.addEventListener("WKE_KEY_UP",onInputEdit);
            _loc3_.addEventListener("WE_UNFOCUS",onInputFocusOut);
            _loc3_.addEventListener("WME_CLICK_AWAY",var_1074.onClickAway);
            return _loc3_;
         }
         return _loc2_;
      }
      
      private function getLinkRegion(param1:Boolean) : IRegionWindow
      {
         var _loc3_:IRegionWindow = null;
         var _loc2_:IRegionWindow = _container.findChildByName("link_container") as IRegionWindow;
         if(_loc2_ == null && param1)
         {
            _loc3_ = template.createLinkContainer(_container) as IRegionWindow;
            _loc3_.addEventListener("WME_DOWN",var_1074.onDown);
            _loc3_.addEventListener("WME_OVER",var_1074.onHoverOver);
            _loc3_.addEventListener("WME_OUT",var_1074.onHoverOut);
            _loc3_.addEventListener("WME_CLICK_AWAY",var_1074.onClickAway);
            _loc3_.addEventListener("WME_CLICK",onLinkClick);
            _loc3_.mouseThreshold = 0;
            return _loc3_;
         }
         return _loc2_;
      }
      
      private function getLinkElement(param1:Boolean) : ITextWindow
      {
         var _loc2_:IRegionWindow = getLinkRegion(param1);
         if(_loc2_ == null)
         {
            return null;
         }
         return _loc2_.findChildByName("element_link") as ITextWindow;
      }
      
      private function getHighlightBorder(param1:Boolean) : class_1993
      {
         var _loc2_:class_1993 = _container.findChildByName("highlight_border") as class_1993;
         if(_loc2_ == null && param1)
         {
            return template.createHighlightBorder(_container) as class_1993;
         }
         return _loc2_;
      }
      
      private function getExtraButtonRegion(param1:Boolean) : IRegionWindow
      {
         var _loc3_:IRegionWindow = null;
         var _loc2_:IRegionWindow = _container.findChildByName("extra_button") as IRegionWindow;
         if(_loc2_ == null && param1)
         {
            _loc3_ = template.createExtraButton(_container) as IRegionWindow;
            _loc3_.addEventListener("WME_CLICK",onExtraButtonClick);
            _loc3_.addEventListener("WME_OVER",var_1074.onHoverOver);
            _loc3_.addEventListener("WME_OUT",var_1074.onHoverOut);
            return _loc3_;
         }
         return _loc2_;
      }
      
      private function getExtraButton(param1:Boolean) : IStaticBitmapWrapperWindow
      {
         var _loc2_:IRegionWindow = getExtraButtonRegion(param1);
         if(_loc2_ == null)
         {
            return null;
         }
         return _loc2_.findChildByName("extra_button_bitmap") as IStaticBitmapWrapperWindow;
      }
      
      private function get template() : CellTemplate
      {
         return var_647.cellTemplate;
      }
      
      private function highlight() : void
      {
         var highlightBorder:class_1993;
         var transitionDuration:Number;
         var delay:int;
         var steps:int;
         var minValue:Number;
         var maxValue:Number;
         var updateValue:* = function(param1:TimerEvent):void
         {
            var _loc2_:Number = easeInOutCubic(_transitionTimer.currentCount,minValue,maxValue - minValue,steps);
            highlightBorder.blend = _loc2_;
         };
         var onTimerComplete:* = function(param1:TimerEvent):void
         {
            highlightBorder.visible = false;
         };
         if(_transitionTimer != null && _transitionTimer.running)
         {
            return;
         }
         highlightBorder = getHighlightBorder(true);
         transitionDuration = 500;
         delay = 16;
         steps = transitionDuration / delay;
         minValue = 0;
         maxValue = 0.35;
         highlightBorder.visible = true;
         highlightBorder.blend = 0;
         if(_transitionTimer != null)
         {
            _transitionTimer.reset();
         }
         else
         {
            _transitionTimer = new Timer(delay,steps);
            _transitionTimer.addEventListener("timer",updateValue);
            _transitionTimer.addEventListener("timerComplete",onTimerComplete);
         }
         _transitionTimer.start();
      }
   }
}

