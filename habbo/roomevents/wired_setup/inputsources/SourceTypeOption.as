package com.sulake.habbo.roomevents.wired_setup.inputsources
{
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.common.class_4050;
   
   public class SourceTypeOption
   {
      
      private var _picker:SourceTypePicker;
      
      private var _container:IRegionWindow;
      
      private var var_1580:int;
      
      private var _active:Boolean = false;
      
      private var var_1919:Boolean = false;
      
      private var var_2482:Boolean = false;
      
      public function SourceTypeOption(param1:SourceTypePicker, param2:IRegionWindow, param3:int)
      {
         super();
         _picker = param1;
         _container = param2;
         var_1580 = param3;
         _container.addEventListener("WME_CLICK",onClick);
         _container.addEventListener("WME_OVER",onOver);
         _container.addEventListener("WME_OUT",onOut);
         var _loc4_:HabboUserDefinedRoomEvents = param1.roomEvents;
         var _loc5_:String = WiredInputSourcePicker.getTypeNameForSource(param3);
         _container.toolTipCaption = _loc4_.localization.getLocalization("wiredfurni.params.sourcetype." + _loc5_);
         bitmapContainer.bitmap = _loc4_.getButtonImage("icon_source_" + _loc5_);
         updateColoring();
      }
      
      public function activate() : void
      {
         _active = true;
         updateColoring();
      }
      
      public function deactivate() : void
      {
         _active = false;
         updateColoring();
      }
      
      private function onOut(param1:WindowMouseEvent) : void
      {
         if(var_2482 || !_container.isEnabled())
         {
            return;
         }
         var_1919 = false;
         updateColoring();
      }
      
      private function onOver(param1:WindowMouseEvent) : void
      {
         if(var_2482 || !_container.isEnabled())
         {
            return;
         }
         var_1919 = true;
         updateColoring();
      }
      
      private function onClick(param1:WindowMouseEvent) : void
      {
         _picker.onClick(this);
      }
      
      internal function backgroundColor() : uint
      {
         var _loc3_:* = 0;
         var _loc1_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc2_:Number = NaN;
         if(!_active && !var_1919)
         {
            return 2236962;
         }
         if(var_1580 == WiredInputSourcePicker.USER_SOURCE)
         {
            _loc3_ = 2526761;
         }
         else if(var_1580 == WiredInputSourcePicker.var_128)
         {
            _loc3_ = 12228630;
         }
         else if(var_1580 == class_4050.CONTEXT_SOURCE)
         {
            _loc3_ = 11558430;
         }
         else
         {
            _loc3_ = 1934221;
         }
         _loc1_ = _loc3_ >> 16 & 0xFF;
         _loc5_ = _loc3_ >> 8 & 0xFF;
         _loc2_ = _loc3_ & 0xFF;
         _loc1_ *= 0.5;
         _loc5_ *= 0.5;
         _loc2_ *= 0.5;
         return uint((_loc1_ << 16) + (_loc5_ << 8) + _loc2_);
      }
      
      private function updateColoring() : void
      {
         elements.color = 0xFF000000 | backgroundColor();
         _picker.colorHasUpdated(this);
      }
      
      public function get option() : int
      {
         return var_1580;
      }
      
      public function get container() : IRegionWindow
      {
         return _container;
      }
      
      public function set disabled(param1:Boolean) : void
      {
         if(param1)
         {
            _container.disable();
         }
         else
         {
            _container.enable();
         }
         var _loc2_:Number = param1 ? 0.5 : 1;
         elements.blend = _loc2_;
         bitmapContainer.blend = _loc2_;
         var_2482 = param1;
         updateColoring();
      }
      
      public function dispose() : void
      {
         if(_container != null)
         {
            _container.dispose();
            _container = null;
         }
      }
      
      private function get bitmapContainer() : class_2251
      {
         return class_2251(_container.findChildByName("type_icon_bitmap"));
      }
      
      private function get elements() : IItemListWindow
      {
         return IItemListWindow(_container.findChildByName("source_elements"));
      }
   }
}

