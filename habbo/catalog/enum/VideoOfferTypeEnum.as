package com.sulake.habbo.catalog.enum
{
   public class VideoOfferTypeEnum
   {
      
      public static const CREDIT:VideoOfferTypeEnum = new VideoOfferTypeEnum(0);
      
      public static const SNOWWAR:VideoOfferTypeEnum = new VideoOfferTypeEnum(1);
      
      private var _value:int = 0;
      
      public function VideoOfferTypeEnum(param1:int)
      {
         super();
         _value = param1;
      }
      
      public function get value() : int
      {
         return _value;
      }
      
      public function equals(param1:VideoOfferTypeEnum) : Boolean
      {
         return param1 && param1._value == _value;
      }
   }
}

