package com.sulake.core.utils
{
   import flash.utils.flash_proxy;
   
   use namespace flash_proxy;
   
   public class class_3346 extends class_55
   {
      
      public function class_3346()
      {
         super();
      }
      
      override flash_proxy function setProperty(param1:*, param2:*) : void
      {
         if(hasKey(param1 is QName ? QName(param1).localName : param1))
         {
            throw new Error("Trying to overwrite value in SingleWriteMap - key: " + param1 + ", value: " + param2);
         }
         super.flash_proxy::setProperty(param1,param2);
      }
   }
}

