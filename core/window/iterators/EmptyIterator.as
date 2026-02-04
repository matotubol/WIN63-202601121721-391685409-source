package com.sulake.core.window.iterators
{
   import com.sulake.core.window.utils.IIterator;
   import flash.utils.Proxy;
   import flash.utils.flash_proxy;
   
   use namespace flash_proxy;
   
   public class EmptyIterator extends Proxy implements IIterator
   {
      
      public static const INSTANCE:EmptyIterator = new EmptyIterator();
      
      public function EmptyIterator()
      {
         super();
      }
      
      public function get length() : uint
      {
         return 0;
      }
      
      public function indexOf(param1:*) : int
      {
         return -1;
      }
      
      override flash_proxy function getProperty(param1:*) : *
      {
         return null;
      }
      
      override flash_proxy function setProperty(param1:*, param2:*) : void
      {
      }
      
      override flash_proxy function nextNameIndex(param1:int) : int
      {
         return 0;
      }
      
      override flash_proxy function nextValue(param1:int) : *
      {
         return null;
      }
   }
}

