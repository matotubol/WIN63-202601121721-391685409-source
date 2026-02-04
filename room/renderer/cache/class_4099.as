package com.sulake.room.renderer.cache
{
   import com.sulake.room.renderer.utils.class_4036;
   
   [SecureSWF(rename="true")]
   public class class_4099
   {
      
      private var _bitmapData:class_4036 = null;
      
      private var _name:String = "";
      
      private var var_719:int = 0;
      
      public function class_4099(param1:class_4036, param2:String)
      {
         super();
         _bitmapData = param1;
         _name = param2;
         if(param1 != null)
         {
            param1.addReference();
            var_719 = _bitmapData.width * _bitmapData.height * 4;
         }
      }
      
      public function get bitmapData() : class_4036
      {
         return _bitmapData;
      }
      
      public function get memUsage() : int
      {
         return var_719;
      }
      
      public function get useCount() : int
      {
         if(_bitmapData == null)
         {
            return 0;
         }
         return _bitmapData.referenceCount;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set bitmapData(param1:class_4036) : void
      {
         if(_bitmapData == param1)
         {
            return;
         }
         if(_bitmapData != null)
         {
            _bitmapData.dispose();
         }
         _bitmapData = param1;
         if(_bitmapData != null)
         {
            _bitmapData.addReference();
            var_719 = _bitmapData.width * _bitmapData.height * 4;
         }
         else
         {
            var_719 = 0;
         }
      }
      
      public function dispose() : void
      {
         if(_bitmapData != null)
         {
            _bitmapData.dispose();
            _bitmapData = null;
         }
         var_719 = 0;
      }
   }
}

