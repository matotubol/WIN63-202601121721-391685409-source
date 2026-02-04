package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.newvariablepicker.overview
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IIconWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2052;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.newvariablepicker.NewVariablePicker;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class VariableNodeView implements class_13
   {
      
      private static var HOVER_BG:uint = 4292927712;
      
      private static var MODE1_BG:uint = 4293914607;
      
      private static var MODE2_BG:uint = 4294638330;
      
      private var var_2502:VariableNode;
      
      private var _picker:NewVariablePicker;
      
      private var _window:IRegionWindow;
      
      private var _style:WiredStyle;
      
      private var var_2138:int;
      
      private var var_1919:Boolean = false;
      
      private var var_3391:Boolean = false;
      
      private var var_3306:Boolean = false;
      
      private var _parent:VariableNodeListView;
      
      private var var_2504:VariableNodeListView = null;
      
      private var _disposed:Boolean;
      
      public function VariableNodeView(param1:VariableNode, param2:NewVariablePicker, param3:VariableNodeListView, param4:int)
      {
         super();
         var_2502 = param1;
         _picker = param2;
         var_2138 = param4;
         _parent = param3;
         _style = param2.roomEvents.wiredCtrl.wiredStyle;
         _window = param2.roomEvents.variablePickerHelper.acquireNodeView(_style);
         var_3391 = param1.canBeSelected(param2);
         var_3306 = param1.isDisabled(param2);
         icon.visible = param1.childrenCount > 0;
         nodeName.text = param1.name;
         _window.interactiveCursorDisabled = !var_3391;
         nodeName.blend = var_3306 ? 0.55 : 1;
         icon.blend = var_3306 ? 0.55 : 1;
         _window.addEventListener("WME_CLICK",onClick);
         _window.addEventListener("WME_OVER",onOver);
         var _loc5_:class_27 = _picker.roomEvents.localization;
         if(var_3306)
         {
            _window.toolTipCaption = _loc5_.getLocalization("wiredfurni.variable_picker.tooltip_disabled");
         }
         else if(!var_3391)
         {
            _window.toolTipCaption = _loc5_.getLocalization("wiredfurni.variable_picker.tooltip_not_selectable");
         }
         else
         {
            _window.toolTipCaption = "";
         }
         updateColoring();
      }
      
      private function updateColoring() : void
      {
         if(var_1919)
         {
            _window.color = HOVER_BG;
         }
         else if(var_2138 % 2 == 0)
         {
            _window.color = MODE1_BG;
         }
         else
         {
            _window.color = MODE2_BG;
         }
      }
      
      protected function onClick(param1:WindowMouseEvent) : void
      {
         if(!var_3391)
         {
            return;
         }
         _picker.select(var_2502.variable);
      }
      
      private function onOver(param1:WindowMouseEvent) : void
      {
         _parent.setHover(this);
      }
      
      internal function set hover(param1:Boolean) : void
      {
         if(var_1919 == param1)
         {
            return;
         }
         var_1919 = param1;
         updateColoring();
         if(variableNode.childrenCount > 0)
         {
            if(var_1919)
            {
               initSublist();
            }
            else
            {
               removeSublist();
            }
         }
      }
      
      private function initSublist() : void
      {
         var_2504 = new VariableNodeListView(_picker,variableNode.children,_window.width);
         var _loc4_:class_1812 = var_2504.window;
         var _loc5_:class_1812 = _picker.expandedView.window;
         _loc5_.addChild(_loc4_);
         var _loc6_:Point = new Point();
         window.getGlobalPosition(_loc6_);
         var _loc2_:Point = new Point();
         _loc5_.getGlobalPosition(_loc2_);
         _loc4_.x = _loc6_.x - _loc2_.x + _window.width + _parent.scrollbarWidth;
         _loc4_.y = _loc6_.y - _loc2_.y;
         var _loc3_:class_2052 = _loc4_.desktop;
         var _loc1_:Rectangle = new Rectangle();
         _loc4_.getGlobalRectangle(_loc1_);
         if(_loc1_.bottom > _loc3_.bottom)
         {
            _loc4_.offset(0,_loc3_.bottom - _loc1_.bottom);
            if(_loc4_.y < 0)
            {
               _loc4_.y = 0;
            }
         }
      }
      
      private function removeSublist() : void
      {
         if(var_2504 == null)
         {
            return;
         }
         (_window.parent as class_1812).removeChild(var_2504.window);
         var_2504.dispose();
      }
      
      public function get variableNode() : VariableNode
      {
         return var_2502;
      }
      
      public function get window() : IRegionWindow
      {
         return _window;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         removeSublist();
         _window.removeEventListener("WME_CLICK",onClick);
         _window.removeEventListener("WME_OVER",onOver);
         _picker.roomEvents.variablePickerHelper.releaseNodeView(_style,_window);
         _picker = null;
         _window = null;
         _style = null;
         var_2502 = null;
         var_2138 = 0;
         var_1919 = false;
         _parent = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function get icon() : IIconWindow
      {
         return _window.findChildByName("right_triangle_icon") as IIconWindow;
      }
      
      private function get nodeName() : ITextWindow
      {
         return _window.findChildByName("node_name") as ITextWindow;
      }
      
      private function get sublistWrapper() : class_1812
      {
         return _window.findChildByName("sublist_wrapper") as class_1812;
      }
   }
}

