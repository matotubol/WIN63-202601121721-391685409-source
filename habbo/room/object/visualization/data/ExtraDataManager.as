package com.sulake.habbo.room.object.visualization.data
{
   import com.sulake.habbo.room.object.visualization.furniture.FurnitureExternalImageVisualization;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.utils.setInterval;
   
   public class ExtraDataManager
   {
      
      public static const STATUS_REJECTED:String = "REJECTED";
      
      private static const BATCH_MAX_QUERY_AMOUNT:int = 50;
      
      private static var instance:ExtraDataManager;
      
      private var inputVisualizationQueue:Vector.<FurnitureExternalImageVisualization> = new Vector.<FurnitureExternalImageVisualization>();
      
      private var outputVisualizationQueue:Vector.<FurnitureExternalImageVisualization> = new Vector.<FurnitureExternalImageVisualization>();
      
      public function ExtraDataManager()
      {
         super();
         setTimedBatchCheck();
      }
      
      private static function getInstance() : ExtraDataManager
      {
         if(!instance)
         {
            instance = new ExtraDataManager();
         }
         return instance;
      }
      
      public static function requestExtraDataUrl(param1:FurnitureExternalImageVisualization) : void
      {
         getInstance().inputVisualizationQueue.push(param1);
      }
      
      public static function furnitureDisposed(param1:FurnitureExternalImageVisualization) : void
      {
         getInstance().removeFurniFromManager(param1);
      }
      
      private function setTimedBatchCheck() : void
      {
         setInterval(handleBatch,200);
      }
      
      private function removeFurniFromManager(param1:FurnitureExternalImageVisualization) : void
      {
         if(inputVisualizationQueue.indexOf(param1) != -1)
         {
            inputVisualizationQueue.splice(inputVisualizationQueue.indexOf(param1),1);
         }
         if(outputVisualizationQueue.indexOf(param1) != -1)
         {
            outputVisualizationQueue.splice(outputVisualizationQueue.indexOf(param1),1);
         }
      }
      
      private function handleBatch() : void
      {
         var _loc8_:String = null;
         var _loc4_:int = 0;
         var _loc5_:FurnitureExternalImageVisualization = null;
         var _loc7_:String = null;
         if(inputVisualizationQueue.length == 0)
         {
            return;
         }
         var _loc2_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < 50)
         {
            if(inputVisualizationQueue.length > 0)
            {
               _loc5_ = inputVisualizationQueue.shift();
               _loc7_ = _loc5_.getExternalImageUUID();
               _loc2_.push(_loc7_);
               _loc8_ = _loc5_.getExtraDataUrl();
               outputVisualizationQueue.push(_loc5_);
            }
            _loc4_++;
         }
         if(_loc2_.length == 0)
         {
            return;
         }
         var _loc1_:URLRequest = new URLRequest();
         _loc1_.method = "POST";
         _loc1_.contentType = "application/json";
         var _loc6_:String = JSON.stringify(_loc2_);
         _loc1_.data = _loc6_;
         _loc1_.url = _loc8_;
         var _loc3_:URLLoader = new URLLoader(_loc1_);
         _loc3_.dataFormat = "text";
         _loc3_.addEventListener("complete",onExtraDataLoaded);
         _loc3_.addEventListener("ioError",onExtraDataError);
      }
      
      private function onExtraDataLoaded(param1:Event) : void
      {
         var _loc2_:Array = null;
         var _loc6_:String = null;
         var _loc4_:String = param1.currentTarget.data;
         if(_loc4_ && _loc4_.length > 0)
         {
            try
            {
               _loc2_ = JSON.parse(_loc4_) as Array;
               for each(var _loc5_ in _loc2_)
               {
                  _loc6_ = _loc5_.id;
                  for each(var _loc3_ in outputVisualizationQueue)
                  {
                     if(_loc3_.getExternalImageUUID() == _loc6_)
                     {
                        if(_loc5_.status && _loc5_.status == "REJECTED")
                        {
                           _loc3_.onUrlFromExtraDataService("REJECTED");
                        }
                        else
                        {
                           _loc3_.onUrlFromExtraDataService(_loc5_.url);
                        }
                        removeFurniFromManager(_loc3_);
                     }
                  }
               }
            }
            catch(error:Error)
            {
               class_21.log("Failed to read JSON from ExtraData service");
            }
         }
      }
      
      private function onExtraDataError(param1:IOErrorEvent) : void
      {
         class_21.log("Failed to load ExtraData batch " + param1.toString());
      }
   }
}

