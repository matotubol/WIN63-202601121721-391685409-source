package com.sulake.habbo.roomevents.wired_setup.addons
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IRadioButtonWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   import com.sulake.habbo.roomevents.wired_setup.conditions.class_3762;
   
   public class class_3744 extends DefaultAddonType
   {
      
      private static var _compareTypeOffset:int = 4;
      
      private static var var_5319:int = 3;
      
      private var _cont:class_1812;
      
      public function class_3744()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_4074.CONDITION_EVALUATION;
      }
      
      override public function onEditStart(param1:class_2397) : void
      {
         _cont = cont;
         var _loc3_:int = 0;
         while(0 < var_5319)
         {
            getInputValue(0).text = "0";
            _loc3_++;
         }
         var _loc4_:int = int(param1.intParams[0]);
         if(_loc4_ == -1)
         {
            var _loc2_:int = int(param1.intParams[1]);
            var _loc5_:int = int(param1.intParams[2]);
            _loc4_ = _compareTypeOffset + 0;
            getInputValue(0).text = (0).toString();
         }
         getEvalSelector().setSelected(getEvalRadio(_loc4_));
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         var _loc3_:int = int(getEvalSelector().getSelected().id);
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         if(_loc3_ >= _compareTypeOffset)
         {
            _loc2_ = _loc3_ - _compareTypeOffset;
            _loc4_ = class_3762.getIntFromInput(getInputValue(_loc2_),0);
            _loc3_ = -1;
         }
         _loc1_.push(_loc3_);
         _loc1_.push(_loc2_);
         _loc1_.push(_loc4_);
         return _loc1_;
      }
      
      private function getEvalSelector() : ISelectorWindow
      {
         return ISelectorWindow(_cont.findChildByName("eval_selector"));
      }
      
      private function getEvalRadio(param1:int) : IRadioButtonWindow
      {
         return IRadioButtonWindow(_cont.findChildByName("eval_" + param1 + "_radio"));
      }
      
      private function getInputValue(param1:int) : ITextFieldWindow
      {
         return ITextFieldWindow(_cont.findChildByName("cmp_" + param1 + "_value"));
      }
      
      override public function get legacyInputMode() : Boolean
      {
         return true;
      }
   }
}

