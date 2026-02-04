package com.sulake.habbo.quest
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.components.class_2251;
   import flash.display.BitmapData;
   
   public class Animation implements class_13
   {
      
      private var var_110:class_2251;
      
      private var var_1538:int;
      
      private var var_1677:Boolean;
      
      private var var_170:Array = [];
      
      public function Animation(param1:class_2251)
      {
         super();
         var_110 = param1;
         var_110.visible = false;
         if(param1.bitmap == null)
         {
            param1.bitmap = new BitmapData(param1.width,param1.height,true,0);
         }
      }
      
      public function dispose() : void
      {
         var_110 = null;
         if(var_170)
         {
            for each(var _loc1_ in var_170)
            {
               _loc1_.dispose();
            }
            var_170 = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return var_110 == null;
      }
      
      public function addObject(param1:AnimationObject) : void
      {
         var_170.push(param1);
      }
      
      public function stop() : void
      {
         var_1677 = false;
         var_110.visible = false;
      }
      
      public function restart() : void
      {
         var_1538 = 0;
         var_1677 = true;
         for each(var _loc1_ in var_170)
         {
            _loc1_.onAnimationStart();
         }
         draw();
         var_110.visible = true;
      }
      
      public function update(param1:uint) : void
      {
         if(var_1677)
         {
            var_1538 += param1;
            draw();
         }
      }
      
      private function draw() : void
      {
         var _loc1_:Boolean = false;
         var _loc3_:BitmapData = null;
         var_110.bitmap.fillRect(var_110.bitmap.rect,0);
         if(var_1677)
         {
            _loc1_ = false;
            for each(var _loc2_ in var_170)
            {
               if(!_loc2_.isFinished(var_1538))
               {
                  _loc1_ = true;
                  _loc3_ = _loc2_.getBitmap(var_1538);
                  if(_loc3_ != null)
                  {
                     var_110.bitmap.copyPixels(_loc3_,_loc3_.rect,_loc2_.getPosition(var_1538));
                  }
               }
            }
         }
         var_110.invalidate();
         var_1677 = _loc1_;
      }
   }
}

