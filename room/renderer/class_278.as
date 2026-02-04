package com.sulake.room.renderer
{
   import com.sulake.core.runtime.class_15;
   import com.sulake.core.runtime.class_17;
   
   [SecureSWF(rename="true")]
   public class class_278 extends class_17 implements IRoomRendererFactory
   {
      
      public function class_278(param1:class_15, param2:uint = 0)
      {
         super(param1,param2);
      }
      
      public function createRenderer() : IRoomRenderer
      {
         return new class_2019(this);
      }
   }
}

