package com.sulake.core.assets.loaders
{
   import com.probertson.utils.class_3131;
   import flash.errors.IllegalOperationError;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   
   public class TextFileLoader extends BinaryFileLoader implements class_1739
   {
      
      public function TextFileLoader(param1:String, param2:URLRequest = null, param3:int = -1)
      {
         super(param1,param2,param3);
      }
      
      override protected function retry() : Boolean
      {
         if(!_disposed)
         {
            if(++var_461 <= var_4169)
            {
               try
               {
                  var_75.close();
               }
               catch(e:Error)
               {
               }
               var_75.load(new URLRequest(var_989 + (var_989.indexOf("?") == -1 ? "?" : "&") + "retry=" + var_461));
               return true;
            }
         }
         return false;
      }
      
      override protected function loadEventHandler(param1:Event) : void
      {
         if(param1.type == "complete")
         {
            unCompress();
         }
         super.loadEventHandler(param1);
      }
      
      private function unCompress() : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:class_3131 = null;
         var _loc1_:String = "";
         if(var_75.data is ByteArray)
         {
            _loc2_ = var_75.data as ByteArray;
            if(_loc2_.length == 0)
            {
               _loc1_ = "";
            }
            else
            {
               try
               {
                  _loc3_ = new class_3131();
                  _loc1_ = _loc3_.uncompressToByteArray(_loc2_).toString();
               }
               catch(error:IllegalOperationError)
               {
                  _loc2_.position = 0;
                  _loc1_ = _loc2_.readUTFBytes(_loc2_.length);
               }
            }
            _loc2_.position = 0;
         }
         else
         {
            _loc1_ = var_75.data as String;
         }
         var_75.data = _loc1_;
      }
   }
}

