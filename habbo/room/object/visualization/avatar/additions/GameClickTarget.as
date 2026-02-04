package com.sulake.habbo.room.object.visualization.avatar.additions
{
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   import flash.display.BitmapData;
   
   public class GameClickTarget implements class_2504
   {
      
      private static const WIDTH:int = 46;
      
      private static const HEIGHT:int = 60;
      
      private static const const_376:int = -23;
      
      private static const const_548:int = -48;
      
      private var var_197:int = -1;
      
      private var _bitmap:BitmapData;
      
      private var _disposed:Boolean;
      
      public function GameClickTarget(param1:int)
      {
         super();
         var_197 = param1;
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            _bitmap = null;
            _disposed = true;
         }
      }
      
      public function animate(param1:IRoomObjectSprite) : Boolean
      {
         return false;
      }
      
      public function update(param1:IRoomObjectSprite, param2:Number) : void
      {
         if(!param1)
         {
            return;
         }
         if(!_bitmap)
         {
            _bitmap = new BitmapData(46,60,true,0);
         }
         param1.visible = true;
         param1.asset = _bitmap;
         param1.offsetX = -23;
         param1.offsetY = -48;
         param1.alphaTolerance = -1;
      }
   }
}

