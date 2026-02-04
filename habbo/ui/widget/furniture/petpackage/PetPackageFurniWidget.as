package com.sulake.habbo.ui.widget.furniture.petpackage
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.class_1750;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPetPackageUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetOpenPetPackageMessage;
   import com.sulake.habbo.window.class_38;
   import flash.display.BitmapData;
   import flash.events.IEventDispatcher;
   import flash.geom.Point;
   
   public class PetPackageFurniWidget extends RoomWidgetBase
   {
      
      private static const GNOME_SPECIES_TYPE_ID:int = 26;
      
      private var _window:class_2250;
      
      private var var_3814:int = -1;
      
      private var var_315:int = -1;
      
      private var var_867:BitmapData;
      
      private var var_1543:Boolean = false;
      
      public function PetPackageFurniWidget(param1:IRoomWidgetHandler, param2:class_38, param3:class_40, param4:class_27)
      {
         super(param1,param2,param3,param4);
      }
      
      override public function dispose() : void
      {
         hideInterface();
         super.dispose();
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener("RWOPPUE_OPEN_PET_PACKAGE_REQUESTED",onObjectUpdate);
         param1.addEventListener("RWOPPUE_OPEN_PET_PACKAGE_RESULT",onObjectUpdate);
         param1.addEventListener("RWOPPUE_OPEN_PET_PACKAGE_UPDATE_PET_IMAGE",onObjectUpdate);
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener("RWOPPUE_OPEN_PET_PACKAGE_REQUESTED",onObjectUpdate);
         param1.removeEventListener("RWOPPUE_OPEN_PET_PACKAGE_RESULT",onObjectUpdate);
         param1.removeEventListener("RWOPPUE_OPEN_PET_PACKAGE_UPDATE_PET_IMAGE",onObjectUpdate);
         super.unregisterUpdateEvents(param1);
      }
      
      private function onObjectUpdate(param1:RoomWidgetPetPackageUpdateEvent) : void
      {
         var nameValidationStatus:int;
         var nameValidationInfo:String;
         var error:String;
         var resultMessage:String;
         var event:RoomWidgetPetPackageUpdateEvent = param1;
         switch(event.type)
         {
            case "RWOPPUE_OPEN_PET_PACKAGE_REQUESTED":
               hideInterface();
               var_315 = event.objectId;
               var_867 = event.image;
               var_3814 = event.typeId;
               showInterface();
               showPetImage();
               break;
            case "RWOPPUE_OPEN_PET_PACKAGE_RESULT":
               if(!var_1543)
               {
                  return;
               }
               var_1543 = false;
               nameValidationStatus = event.nameValidationStatus;
               nameValidationInfo = event.nameValidationInfo;
               switch(nameValidationStatus)
               {
                  case 0:
                     hideInterface();
                     return;
                  case 1:
                     error = "long";
                     break;
                  case 2:
                     error = "short";
                     break;
                  case 3:
                     error = "chars";
                     break;
                  default:
                     error = "bobba";
               }
               resultMessage = constructErrorMessage(error,nameValidationInfo);
               windowManager.alert("${widgets.petpackage.alert.petname.title}",resultMessage,0,function(param1:class_1750, param2:class_1758):void
               {
                  param1.dispose();
               });
               break;
            case "RWOPPUE_OPEN_PET_PACKAGE_UPDATE_PET_IMAGE":
               if(event.objectId != var_315)
               {
                  return;
               }
               var_867 = event.image;
               showPetImage();
         }
      }
      
      private function constructErrorMessage(param1:String, param2:String) : String
      {
         var _loc3_:String = "catalog.alert.petname." + param1;
         var _loc5_:String = _loc3_ + ".additionalInfo";
         localizations.registerParameter(_loc5_,"additional_info",param2);
         var _loc6_:String = localizations.getLocalization(_loc3_);
         var _loc4_:String = localizations.getLocalization(_loc5_);
         if(param2 != null && param2.length > 0 && _loc4_ != null && _loc4_.length > 0)
         {
            _loc6_ = _loc4_;
         }
         return _loc6_;
      }
      
      private function hideInterface() : void
      {
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         var_315 = -1;
         var_1543 = false;
         var_867 = null;
      }
      
      private function showInterface() : void
      {
         if(var_315 < 0)
         {
            return;
         }
         var _loc3_:IAsset = var_867 != null ? assets.getAssetByName("petpackage") : assets.getAssetByName("petpackage_new");
         var _loc1_:XmlAsset = XmlAsset(_loc3_);
         if(_loc1_ == null)
         {
            return;
         }
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         _window = windowManager.buildFromXML(XML(_loc1_.content)) as class_2250;
         _window.center();
         var _loc4_:class_1741 = _window.header.findChildByTag("close");
         if(_loc4_)
         {
            _loc4_.addEventListener("WME_CLICK",onWindowClose);
         }
         var _loc2_:class_1741 = _window.findChildByName("pick_name");
         _loc2_ = _window.findChildByName("cancel");
         _window.addEventListener("WME_CLICK",onMouseEvent);
         showPetImage();
      }
      
      private function showPetImage() : void
      {
         if(var_867 == null || _window == null)
         {
            return;
         }
         var _loc1_:class_2251 = _window.findChildByName("pet_image") as class_2251;
         if(_loc1_ != null)
         {
            _loc1_.bitmap = new BitmapData(_loc1_.width,_loc1_.height,true,0);
            var _loc2_:Point = new Point((_loc1_.width - var_867.width) / 2,(_loc1_.height - var_867.height) / 2);
            _loc1_.bitmap.copyPixels(var_867,var_867.rect,null);
         }
      }
      
      private function onWindowClose(param1:class_1758) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         hideInterface();
      }
      
      private function onMouseEvent(param1:WindowMouseEvent) : void
      {
         var _loc2_:class_1741 = param1.target as class_1741;
         var _loc3_:String = _loc2_.name;
         switch(_loc3_)
         {
            case "pick_name":
               sendOpenPetPackage();
               break;
            case "cancel":
               hideInterface();
         }
      }
      
      private function sendOpenPetPackage() : void
      {
         var name:String;
         var message:RoomWidgetOpenPetPackageMessage;
         if(var_1543 || var_315 == -1)
         {
            return;
         }
         name = getName();
         if(name == null || name.length < 1)
         {
            windowManager.alert("${widgets.petpackage.alert.petname.title}","${catalog.alert.petname.short}",0,function(param1:class_1750, param2:class_1758):void
            {
               param1.dispose();
            });
            return;
         }
         if(messageListener != null)
         {
            var_1543 = true;
            message = new RoomWidgetOpenPetPackageMessage("RWOPPM_OPEN_PET_PACKAGE",var_315,name);
            messageListener.processWidgetMessage(message);
         }
      }
      
      private function getName() : String
      {
         var _loc1_:ITextFieldWindow = null;
         if(_window)
         {
            _loc1_ = _window.findChildByName("input") as ITextFieldWindow;
            if(_loc1_)
            {
               return _loc1_.text;
            }
         }
         return null;
      }
   }
}

