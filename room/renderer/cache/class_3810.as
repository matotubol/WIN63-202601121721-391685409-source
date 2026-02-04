package com.sulake.room.renderer.cache
{
   import com.sulake.room.renderer.utils.class_3782;
   
   [SecureSWF(rename="true")]
   public class class_3810
   {
      
      private var var_170:Array = [];
      
      private var _updateId1:int = -1;
      
      private var _updateId2:int = -1;
      
      private var var_3187:Boolean = false;
      
      public function class_3810()
      {
         super();
      }
      
      public function get spriteCount() : int
      {
         return var_170.length;
      }
      
      public function get isEmpty() : Boolean
      {
         return var_3187;
      }
      
      public function dispose() : void
      {
         setSpriteCount(0);
      }
      
      public function addSprite(param1:class_3782) : void
      {
         var_170.push(param1);
      }
      
      public function getSprite(param1:int) : class_3782
      {
         return var_170[param1];
      }
      
      public function get sprites() : Array
      {
         return var_170;
      }
      
      public function needsUpdate(param1:int, param2:int) : Boolean
      {
         if(param1 != _updateId1 || param2 != _updateId2)
         {
            _updateId1 = param1;
            _updateId2 = param2;
            return true;
         }
         return false;
      }
      
      public function setSpriteCount(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:class_3782 = null;
         if(param1 < var_170.length)
         {
            _loc3_ = param1;
            while(_loc3_ < var_170.length)
            {
               _loc2_ = var_170[_loc3_];
               if(_loc2_)
               {
                  _loc2_.dispose();
               }
               _loc3_++;
            }
            var_170.splice(param1,var_170.length - param1);
         }
         if(var_170.length == 0)
         {
            var_3187 = true;
         }
         else
         {
            var_3187 = false;
         }
      }
   }
}

