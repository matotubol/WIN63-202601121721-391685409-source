package com.sulake.habbo.roomevents.wired_setup.conditions
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   import flash.globalization.DateTimeFormatter;
   
   public class class_3979 extends DefaultConditionType
   {
      
      public function class_3979()
      {
         super();
      }
      
      private static function getDate(param1:class_1812, param2:String) : Number
      {
         return Date.parse(ITextFieldWindow(param1.findChildByName(param2)).text);
      }
      
      override public function get code() : int
      {
         return class_4100.DATE_RANGE_ACTIVE;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc2_:Number = NaN;
         var _loc1_:Array = [];
         var _loc3_:Number = getDate(cont,"start_date");
         if(!isNaN(_loc3_))
         {
            _loc1_.push(int(_loc3_ / 1000));
            _loc2_ = getDate(cont,"end_date");
            if(!isNaN(_loc2_))
            {
               _loc1_.push(int(_loc2_ / 1000));
            }
         }
         return _loc1_;
      }
      
      override public function onEditStart(param1:class_2397) : void
      {
         var _loc3_:DateTimeFormatter = new DateTimeFormatter("en-US");
         _loc3_.setDateTimePattern("yyyy/MM/dd HH:mm");
         if(param1.intParams.length > 0)
         {
            var _loc4_:Date = new Date(param1.intParams[0] * 1000);
            ITextFieldWindow(cont.findChildByName("start_date")).text = _loc3_.format(null);
         }
         else
         {
            ITextFieldWindow(cont.findChildByName("start_date")).text = "";
         }
         if(param1.intParams.length > 1)
         {
            var _loc2_:Date = new Date(param1.intParams[1] * 1000);
            ITextFieldWindow(cont.findChildByName("end_date")).text = _loc3_.format(null);
         }
         else
         {
            ITextFieldWindow(cont.findChildByName("end_date")).text = "";
         }
      }
      
      override public function get legacyInputMode() : Boolean
      {
         return true;
      }
   }
}

