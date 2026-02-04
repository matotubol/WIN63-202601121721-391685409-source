package com.sulake.habbo.window.widgets
{
   import com.sulake.core.runtime.class_31;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.iterators.EmptyIterator;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   
   public class RunningNumberWidget implements IRunningNumberWidget, class_31
   {
      
      public static const TYPE:String = "running_number";
      
      private static const NUMBER_KEY:String = "running_number:number";
      
      private static const const_594:String = "running_number:digits";
      
      private static const COLOR_STYLE_KEY:String = "running_number:color_style";
      
      private static const const_766:String = "running_number:update_frequency";
      
      private static const NUMBER_DEFAULT:PropertyStruct = new PropertyStruct("running_number:number",0,"int");
      
      private static const DIGITS_DEFAULT:PropertyStruct = new PropertyStruct("running_number:digits",8,"uint");
      
      private static const COLOR_STYLE_DEFAULT:PropertyStruct = new PropertyStruct("running_number:color_style",0,"int");
      
      private static const UPDATE_FREQUENCY_DEFAULT:PropertyStruct = new PropertyStruct("running_number:update_frequency",50,"int");
      
      private var _disposed:Boolean;
      
      private var var_210:class_2010;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var var_134:class_1812;
      
      private var var_2986:int = int(COLOR_STYLE_DEFAULT.value);
      
      private var var_2567:uint = uint(DIGITS_DEFAULT.value);
      
      private var var_1449:int = int(UPDATE_FREQUENCY_DEFAULT.value);
      
      private var _newNumber:int = int(NUMBER_DEFAULT.value);
      
      private var _displayedNumber:Number = 0;
      
      private var _millisSinceLastUpdate:uint = 0;
      
      public function RunningNumberWidget(param1:class_2010, param2:HabboWindowManagerComponent)
      {
         super();
         var_210 = param1;
         _windowManager = param2;
         var_134 = _windowManager.buildFromXML(_windowManager.assets.getAssetByName("running_number_xml").content as XML) as class_1812;
         _windowManager.registerUpdateReceiver(this,var_1449);
         var_210.setParamFlag(147456);
         var_210.rootWindow = var_134;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(var_134 != null)
            {
               var_134.dispose();
               var_134 = null;
            }
            if(var_210 != null)
            {
               var_210.rootWindow = null;
               var_210 = null;
            }
            _windowManager.removeUpdateReceiver(this);
            _windowManager = null;
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get properties() : Array
      {
         var _loc1_:Array = [];
         if(_disposed)
         {
            return _loc1_;
         }
         _loc1_.push(NUMBER_DEFAULT.withValue(colorStyle));
         _loc1_.push(COLOR_STYLE_DEFAULT.withValue(colorStyle));
         _loc1_.push(DIGITS_DEFAULT.withValue(digits));
         _loc1_.push(UPDATE_FREQUENCY_DEFAULT.withValue(updateFrequency));
         return _loc1_;
      }
      
      public function set properties(param1:Array) : void
      {
         if(_disposed)
         {
            return;
         }
         for each(var _loc2_ in param1)
         {
            switch(_loc2_.key)
            {
               case "running_number:number":
                  number = int(_loc2_.value);
                  break;
               case "running_number:digits":
                  digits = uint(_loc2_.value);
                  break;
               case "running_number:color_style":
                  colorStyle = int(_loc2_.value);
                  break;
               case "running_number:update_frequency":
                  updateFrequency = int(_loc2_.value);
            }
         }
      }
      
      public function get iterator() : IIterator
      {
         return EmptyIterator.INSTANCE;
      }
      
      public function update(param1:uint) : void
      {
         if(_displayedNumber < number)
         {
            _millisSinceLastUpdate += param1;
            if(_millisSinceLastUpdate > var_1449)
            {
               _displayedNumber = Math.min(_newNumber,_displayedNumber + _millisSinceLastUpdate / var_1449);
               _millisSinceLastUpdate -= var_1449;
            }
            fieldValue = _displayedNumber;
         }
      }
      
      private function set fieldValue(param1:uint) : void
      {
         var _loc3_:String = param1.toString();
         while(_loc3_.length < var_2567)
         {
            _loc3_ = "0" + _loc3_;
         }
         var _loc2_:ITextWindow = ITextWindow(var_134.findChildByName("number_field"));
         _loc2_.text = _loc3_;
         _loc2_.invalidate();
      }
      
      public function get digits() : uint
      {
         return var_2567;
      }
      
      public function set digits(param1:uint) : void
      {
         var_2567 = param1;
      }
      
      public function get colorStyle() : int
      {
         return var_2986;
      }
      
      public function set colorStyle(param1:int) : void
      {
         var_2986 = param1;
      }
      
      public function get updateFrequency() : int
      {
         return var_1449;
      }
      
      public function set updateFrequency(param1:int) : void
      {
         var_1449 = param1;
      }
      
      public function get number() : int
      {
         return _newNumber;
      }
      
      public function set number(param1:int) : void
      {
         _newNumber = param1;
      }
      
      public function set initialNumber(param1:int) : void
      {
         _displayedNumber = param1;
         _newNumber = param1;
         fieldValue = _displayedNumber;
      }
   }
}

