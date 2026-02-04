package com.sulake.habbo.room.object.data
{
   import com.sulake.habbo.room.IStuffData;
   
   public class class_2035
   {
      
      public function class_2035()
      {
         super();
      }
      
      public static function getStuffDataWrapperForType(param1:int) : IStuffData
      {
         var _loc3_:* = param1 & 0xFF;
         var _loc2_:IStuffData = null;
         switch(_loc3_)
         {
            case 0:
               _loc2_ = new class_2108() as IStuffData;
               break;
            case 1:
               _loc2_ = new MapStuffData() as IStuffData;
               break;
            case 2:
               _loc2_ = new StringArrayStuffData() as IStuffData;
               break;
            case 3:
               _loc2_ = new class_3527() as IStuffData;
               break;
            case 4:
               _loc2_ = new EmptyStuffData() as IStuffData;
               break;
            case 5:
               _loc2_ = new class_2551() as IStuffData;
               break;
            case 6:
               _loc2_ = new class_2977() as IStuffData;
               break;
            case 7:
               _loc2_ = new class_3238() as IStuffData;
         }
         if(_loc2_ != null)
         {
            _loc2_.flags = param1 & 0xFF00;
         }
         return _loc2_;
      }
   }
}

