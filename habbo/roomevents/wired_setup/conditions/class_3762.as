package com.sulake.habbo.roomevents.wired_setup.conditions
{
   import com.sulake.core.runtime.class_16;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IRadioButtonWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.class_1885;
   import com.sulake.core.window.components.class_2261;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   import com.sulake.habbo.room.class_34;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.wired_setup.common.utils.ChronoFieldMaskFilter;
   import com.sulake.habbo.roomevents.wired_setup.common.utils.ChronoFieldRangeFilter;
   
   public class class_3762 extends DefaultConditionType
   {
      
      private var _cont:class_1812;
      
      private var var_59:HabboUserDefinedRoomEvents;
      
      private var var_4508:String = "";
      
      public function class_3762()
      {
         super();
      }
      
      private static function getSelector(param1:class_1812) : ISelectorWindow
      {
         return ISelectorWindow(param1.findChildByName("selector"));
      }
      
      private static function getSkipRadio(param1:class_1812) : IRadioButtonWindow
      {
         return IRadioButtonWindow(param1.findChildByName("skip_radio"));
      }
      
      private static function getExactRadio(param1:class_1812) : IRadioButtonWindow
      {
         return IRadioButtonWindow(param1.findChildByName("exact_radio"));
      }
      
      private static function getRangeRadio(param1:class_1812) : IRadioButtonWindow
      {
         return IRadioButtonWindow(param1.findChildByName("range_radio"));
      }
      
      private static function getExactInput(param1:class_1812) : ITextFieldWindow
      {
         return ITextFieldWindow(param1.findChildByName("exact_input"));
      }
      
      private static function getRangeInputMin(param1:class_1812) : ITextFieldWindow
      {
         return ITextFieldWindow(param1.findChildByName("range_min_input"));
      }
      
      private static function getRangeInputMax(param1:class_1812) : ITextFieldWindow
      {
         return ITextFieldWindow(param1.findChildByName("range_max_input"));
      }
      
      public static function getIntFromInput(param1:ITextFieldWindow, param2:int) : int
      {
         var _loc3_:String = param1.text;
         if(isNaN(Number(_loc3_)))
         {
            return param2;
         }
         return int(_loc3_);
      }
      
      private static function getCheckbox(param1:class_1812, param2:int) : class_1885
      {
         return class_1885(param1.findChildByName("checkbox_" + param2));
      }
      
      override public function onInit(param1:class_1812, param2:class_1812, param3:HabboUserDefinedRoomEvents) : void
      {
         super.onInit(param1,param2,param3);
         var_59 = param3;
      }
      
      override public function onEditStart(param1:class_2397) : void
      {
         _cont = cont;
         var _loc2_:String = param1.stringParam == "" ? var_4508 : param1.stringParam;
         populateTimezones(_loc2_,var_59.roomEngine as class_34);
         getSubContainer("timezone").visible = getTimezoneMenu().numMenuItems > 1;
         _cont.height = Util.getLowestPoint(_cont) + 1;
      }
      
      private function populateTimezones(param1:String, param2:class_16) : void
      {
         var _loc7_:int = 0;
         var _loc6_:String = null;
         var _loc4_:class_2261 = getTimezoneMenu();
         var _loc5_:String = param2.getProperty("wired.timezones");
         var _loc3_:Array = _loc5_ == null || _loc5_ == "" ? ["UTC"] : _loc5_.split(",");
         var _loc8_:Vector.<String> = new Vector.<String>();
         if(param1 != "")
         {
            _loc8_.push(param1);
         }
         _loc7_ = 0;
         while(_loc7_ < _loc3_.length)
         {
            _loc6_ = _loc3_[_loc7_];
            if(_loc6_ != param1)
            {
               _loc8_.push(_loc6_);
            }
            _loc7_++;
         }
         _loc4_.populateWithVector(_loc8_);
         if(_loc8_.length > 0)
         {
            _loc4_.selection = 0;
         }
      }
      
      override public function readStringParamFromForm() : String
      {
         var _loc2_:class_2261 = getTimezoneMenu();
         var _loc1_:int = _loc2_.selection;
         if(_loc1_ == -1)
         {
            return "";
         }
         var _loc3_:String = _loc2_.enumerateSelection()[_loc1_];
         var_4508 = _loc3_;
         return _loc3_;
      }
      
      private function getSubContainer(param1:String) : class_1812
      {
         var _loc2_:String = param1 + "_selection";
         return _cont.getChildByName(_loc2_) as class_1812;
      }
      
      protected function initializeRangeFilter(param1:ChronoFieldRangeFilter) : void
      {
         var _loc9_:IRadioButtonWindow = null;
         var _loc2_:class_1812 = getSubContainer(param1.name);
         var _loc8_:ISelectorWindow = getSelector(_loc2_);
         var _loc7_:ITextFieldWindow = getExactInput(_loc2_);
         var _loc5_:ITextFieldWindow = getRangeInputMin(_loc2_);
         var _loc3_:ITextFieldWindow = getRangeInputMax(_loc2_);
         if(!param1.useFilter)
         {
            var _loc4_:IRadioButtonWindow = getSkipRadio(_loc2_);
            _loc8_.setSelected(null);
            _loc7_.text = param1.defaultValue.toString();
            _loc5_.text = param1.defaultValue.toString();
            _loc3_.text = param1.defaultValue.toString();
         }
         else if(param1.min == param1.max)
         {
            var _loc6_:IRadioButtonWindow = getExactRadio(_loc2_);
            _loc8_.setSelected(null);
            _loc7_.text = param1.min.toString();
            _loc5_.text = param1.defaultValue.toString();
            _loc3_.text = param1.defaultValue.toString();
         }
         else
         {
            _loc9_ = getRangeRadio(_loc2_);
            _loc8_.setSelected(_loc9_);
            _loc7_.text = param1.defaultValue.toString();
            _loc5_.text = param1.min.toString();
            _loc3_.text = param1.max.toString();
         }
      }
      
      protected function initializeMaskFilter(param1:ChronoFieldMaskFilter) : void
      {
         var _loc4_:int = 0;
         var _loc3_:class_1885 = null;
         var _loc2_:class_1812 = getSubContainer(param1.name);
         var _loc5_:int = param1.mask;
         _loc4_ = 0;
         while(_loc4_ < param1.amount)
         {
            _loc3_ = getCheckbox(_loc2_,_loc4_);
            if((_loc5_ & 1 << _loc4_) != 0)
            {
               _loc3_.select();
            }
            else
            {
               _loc3_.unselect();
            }
            _loc4_++;
         }
      }
      
      protected function readRangeFilter(param1:String, param2:int = 0) : ChronoFieldRangeFilter
      {
         var _loc7_:ITextFieldWindow = null;
         var _loc5_:ITextFieldWindow = null;
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:class_1812 = getSubContainer(param1);
         var _loc10_:ISelectorWindow = getSelector(_loc3_);
         if(_loc10_.getSelected() == getSkipRadio(_loc3_))
         {
            return new ChronoFieldRangeFilter(param1,false,param2,param2,param2);
         }
         if(_loc10_.getSelected() == getExactRadio(_loc3_))
         {
            var _loc8_:ITextFieldWindow = getExactInput(_loc3_);
            var _loc9_:int = getIntFromInput(null,param2);
            return new ChronoFieldRangeFilter(param1,true,0,0,param2);
         }
         _loc7_ = getRangeInputMin(_loc3_);
         _loc5_ = getRangeInputMax(_loc3_);
         _loc4_ = getIntFromInput(_loc7_,param2);
         _loc6_ = getIntFromInput(_loc5_,param2);
         return new ChronoFieldRangeFilter(param1,true,_loc4_,_loc6_,param2);
      }
      
      protected function readMaskFilter(param1:String, param2:int) : ChronoFieldMaskFilter
      {
         var _loc5_:int = 0;
         var _loc4_:class_1885 = null;
         var _loc3_:class_1812 = getSubContainer(param1);
         _loc5_ = 0;
         while(_loc5_ < param2)
         {
            _loc4_ = getCheckbox(_loc3_,_loc5_);
            if(_loc4_.isSelected)
            {
               var _loc6_:* = 0 | 1 << _loc5_;
            }
            _loc5_++;
         }
         return new ChronoFieldMaskFilter(param1,0,param2);
      }
      
      private function getTimezoneMenu() : class_2261
      {
         return class_2261(_cont.findChildByName("menu_timezone"));
      }
   }
}

