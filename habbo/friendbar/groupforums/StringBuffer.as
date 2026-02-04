package com.sulake.habbo.friendbar.groupforums
{
   public class StringBuffer
   {
      
      private static const GT_CHAR:Number = ">".charCodeAt(0);
      
      private static const LT_CHAR:Number = "<".charCodeAt(0);
      
      private var buffer:Array = [];
      
      public function StringBuffer()
      {
         super();
      }
      
      public function addEscaped(param1:String) : StringBuffer
      {
         var _loc3_:Number = NaN;
         var _loc2_:Number = NaN;
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ = Number(param1.charCodeAt(_loc3_));
            switch(_loc2_)
            {
               case LT_CHAR:
                  add("&lt;");
                  break;
               case GT_CHAR:
                  add("&gt;");
                  break;
               default:
                  buffer.push(_loc2_);
            }
            _loc3_++;
         }
         return this;
      }
      
      public function add(param1:String) : StringBuffer
      {
         var _loc2_:Number = NaN;
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            buffer.push(param1.charCodeAt(_loc2_));
            _loc2_++;
         }
         return this;
      }
      
      public function toString() : String
      {
         return String.fromCharCode.apply(this,buffer);
      }
      
      public function get length() : int
      {
         return buffer.length;
      }
      
      public function reset() : void
      {
         buffer = [];
      }
   }
}

