-- SPDX-License-Identifier: GPL-3.0-only
-- This file is used to document the Lua plugins engine API. It should not be included.
---@meta _
---@diagnostic disable: missing-return 
---@diagnostic disable: unused-local 
Engine = {}

-------------------------------------------------------
-- Data types
-------------------------------------------------------

---@class EngineColorARGB
---@field alpha number
---@field red number
---@field green number
---@field blue number

---@class MetaEngineColorARGB: EngineColorARGB

---@class EngineColorARGBInt
---@field alpha integer
---@field red integer
---@field green integer
---@field blue integer

---@class MetaEngineColorARGBInt: EngineColorARGBInt
---@class MetaEngineTagDataColorARGBInt: EngineColorARGBInt

---@class EngineColorRGB
---@field red number
---@field green number
---@field blue number

---@class MetaEngineColorRGB: EngineColorRGB

---@class EnginePoint2D
---@field x number
---@field y number

---@class MetaEnginePoint2D: EnginePoint2D

---@class EnginePoint2DInt
---@field x integer
---@field y integer

---@class MetaEnginePoint2DInt: EnginePoint2DInt

---@class EnginePoint3D
---@field x number
---@field y number
---@field z number

---@class MetaEnginePoint3D: EnginePoint3D

---@class EngineVector2D
---@field i number
---@field j number

---@class MetaEngineVector2D: EngineVector2D

---@class EngineVector3D
---@field i number
---@field j number
---@field k number

---@class MetaEngineVector3D: EngineVector3D 

---@class EngineResourceHandle
---@field value integer
---@field index integer
---@field id integer

---@class EngineTagHandle: EngineResourceHandle

---@class EngineObjectHandle: EngineResourceHandle

---@class EnginePlayerHandle: EngineResourceHandle

---@class EngineEuler3DPYR
---@field pitch number
---@field yaw number
---@field roll number

---@class MetaEngineEuler3DPYR: EngineEuler3DPYR

---@class EngineEuler2D
---@field yaw number
---@field pitch number

---@class MetaEngineEuler2D: EngineEuler2D

---@class EngineEuler3D
---@field yaw number
---@field pitch number
---@field roll number

---@class MetaEngineEuler3D: EngineEuler3D

---@class EngineRectangle2D
---@field top number
---@field left number
---@field bottom number
---@field right number

---@class MetaEngineRectangle2D: EngineRectangle2D

---@class EngineRectangle2DF
---@field top number
---@field left number
---@field bottom number
---@field right number

---@class MetaEngineRectangle2DF: EngineRectangle2DF

---@class EnginePlane2D
---@field i number
---@field j number

---@class MetaEnginePlane2D: EnginePlane2D

---@class EnginePlane3D: EngineVector3D
---@field w number

---@class MetaEnginePlane3D: EnginePlane3D

---@class MetaEngineTagString : string

---@class EngineTagDependency
---@field handle integer
---@field class string
---@field path string

---@class MetaEngineTagDependency: EngineTagDependency

---@class MetaEngineIndex: integer

---@class EngineTagDataOffset
---@field size integer
---@field external boolean
---@field fileOffset integer | nil
---@field pointer integer | nil

---@class MetaEngineTagDataOffset: EngineTagDataOffset

---@class EngineAngle: number

---@class MetaEngineAngle: EngineAngle

---@class EngineFraction

---@class MetaEngineFraction: EngineFraction

---@class EngineQuaternion
---@field i number
---@field j number
---@field k number
---@field w number

---@class MetaEngineQuaternion: EngineQuaternion

---@class EngineMatrix: table<integer, table<integer, number>>

---@class MetaEngineMatrix: EngineMatrix

---@class EngineScenarioScriptNodeValue
---@field float number
---@field integer integer
---@field tag EngineTagHandle

---@class MetaEngineScenarioScriptNodeValue: EngineScenarioScriptNodeValue

---@alias EngineGenericFont
---| "console"
---| "system"
---| "small"
---| "smaller"
---| "large"
---| "ticker"

---@alias EngineInputDevice
---| "keyboard"
---| "mouse"
---| "gamepad"
---| "unknown"

---@class EngineWidgetRenderVertex
---@field x number
---@field y number
---@field z number
---@field rhw number
---@field u number
---@field v number

---@class EngineUIWidgetRenderVertices
---@field topLeft EngineWidgetRenderVertex
---@field topRight EngineWidgetRenderVertex
---@field bottomLeft EngineWidgetRenderVertex
---@field bottomRight EngineWidgetRenderVertex

-------------------------------------------------------
-- Engine.core
-------------------------------------------------------

Engine.core = {}

-- Print a message of a color in the console; It uses the fmt library to format the message
---@param color EngineColorARGB @The color of the message
---@param format string @The format string in case the first argument is a color
---@param ... string @The arguments to the format string
---@overload fun(format: string, ...: string)
function Engine.core.consolePrint(color, format, ...)
end

-- Get the number of ticks since the engine started
---@return integer
function Engine.core.getTickCount()
end

---@alias EngineEdition
---| 'retail'
---| 'demo'
---| 'custom'

-- Get the game engine used
---@return EngineEdition
function Engine.core.getEngineEdition()
end

-------------------------------------------------------
-- Engine.gameState
-------------------------------------------------------

Engine.gameState = {}

---@class MetaEngineObjectFlags
---@field noCollision boolean
---@field onGround boolean
---@field ignoreGravity boolean
---@field inWater boolean
---@field stationary boolean
---@field noCollision2 boolean
---@field hasSoundLoopingAttachment boolean
---@field connectedToMap boolean
---@field notPlacedAutomatically boolean
---@field isDeviceMachine boolean
---@field isElevator boolean
---@field isElevator2 boolean
---@field isGarbage boolean
---@field noShadow boolean
---@field deleteAtDeactivation boolean
---@field doNotReactivate boolean
---@field outsideOfMap boolean
---@field collidable boolean
---@field hasCollisionModel boolean

---@class MetaEngineObjectNetwork
---@field validPosition boolean
---@field position MetaEngineVector3D
---@field validForwardAndUp boolean
---@field orientation table<integer, MetaEnginePoint3D>
---@field validTransitionalVelocity boolean
---@field transitionalVelocity MetaEnginePoint3D
---@field validTimestamp boolean
---@field timestamp integer

---@class MetaEngineScenarioLocation
---@field leafId integer
---@field clusterIndex integer

---@class MetaEngineObjectVitalsFlags
---@field healthDamageEffectApplied boolean
---@field shieldDamageEffectApplied boolean
---@field healthDepleted boolean
---@field shieldDepleted boolean
---@field killed boolean
---@field killedSilent boolean
---@field cannotMeleeAttack boolean
---@field invulnerable boolean
---@field shieldRecharging boolean
---@field killedNoStats boolean

---@class MetaEngineObjectAttachmentsData
---@field types table<integer, string>
---@field attachments table<integer, integer>
---@field firstWidget integer

---@class MetaEngineObjectRegionDestroyeds
---@field region0 boolean
---@field region1 boolean
---@field region2 boolean
---@field region3 boolean
---@field region4 boolean
---@field region5 boolean
---@field region6 boolean
---@field region7 boolean

---@class MetaEngineObjectBlockReference
---@field size integer
---@field offset integer

---@class MetaEngineBaseObject
---@field tagHandle EngineTagHandle
---@field networkRole string
---@field shouldForceBaselineUpdate boolean
---@field existenceTime integer
---@field flags MetaEngineObjectFlags
---@field objectMarkerId integer
---@field network MetaEngineObjectNetwork
---@field position MetaEnginePoint3D
---@field velocity MetaEnginePoint3D
---@field orientation table<integer, MetaEnginePoint3D>
---@field rotationVelocity MetaEngineEuler3DPYR
---@field scenarioLocation MetaEngineScenarioLocation
---@field centerPosition MetaEnginePoint3D
---@field boundingRadius number
---@field scale number
---@field type string
---@field teamOwner string
---@field multiplayerTeamOwner string
---@field nameListIndex integer
---@field movingTime integer
---@field variantIndex integer
---@field player integer
---@field ownerObject integer
---@field animationTagHandle integer
---@field animationIndex integer
---@field animationFrame integer
---@field animationInterpolationFrame integer
---@field animationInterpolationFrameCount integer
---@field vitals MetaEngineObjectVitalsFlags
---@field clusterPartition integer
---@field unknownObject integer
---@field nextObject integer
---@field firstObject integer
---@field parentObject integer
---@field parentAttachmentNode integer
---@field forceShieldUpdate boolean
---@field attachmentData MetaEngineObjectAttachmentsData
---@field cachedRenderState integer
---@field regionDestroyeds MetaEngineObjectRegionDestroyeds
---@field shaderPermutation integer
---@field regionHealths table<integer, integer>
---@field regionPermutationIds table<integer, integer>
---@field colorChange table<integer, MetaEngineColorRGB>
---@field colorChange2 table<integer, MetaEngineColorRGB>
---@field nodeOrientations table<integer, MetaEngineObjectBlockReference>
---@field nodeMatricesBlock MetaEngineObjectBlockReference

---@class MetaEngineUnitFlags
---@field unknownBipedSpeechRelated boolean
---@field powerUp boolean
---@field powerUpAddition boolean
---@field controllable boolean
---@field berserking boolean
---@field unknownIntegratedLightRelated boolean
---@field willNotDropItems boolean
---@field unknown boolean
---@field canBlink boolean
---@field impervious boolean
---@field suspended boolean
---@field blind boolean
---@field unknownNvRelated boolean
---@field possessed boolean
---@field desiresFlashlightOn boolean
---@field desiresFlashlightOff boolean

---@class MetaEngineUnitControlFlags
---@field crouch boolean
---@field jump boolean
---@field user1 boolean
---@field user2 boolean
---@field light boolean
---@field exactFacing boolean
---@field action boolean
---@field melee boolean
---@field lookDontTurn boolean
---@field forceAlert boolean
---@field reload boolean
---@field primaryTrigger boolean
---@field secondaryTrigger boolean
---@field grenade boolean
---@field exchangeWeapon boolean

---@class MetaEngineUnitAnimationFlags
---@field animationBit0Unknown boolean
---@field animationBit1Unknown boolean
---@field animationBit2Unknown boolean
---@field animationBit3Unknown boolean

---@class MetaEngineUnitAnimationStateData
---@field animationIndex integer
---@field frameIndex integer

---@class MetaEngineUnitAnimationData
---@field flags MetaEngineUnitAnimationFlags
---@field unknownSomeAnimationIndexMaybe integer
---@field unknownSomeAnimationIndex integer
---@field seatIndex integer
---@field seatWeaponIndex integer
---@field weaponTypeIndex integer
---@field state string
---@field replacementState string
---@field overlayState string
---@field desiredState string
---@field baseSeat string
---@field emotion integer
---@field replacementAnimation MetaEngineUnitAnimationStateData
---@field overlayStateAnimation MetaEngineUnitAnimationStateData
---@field weaponIK MetaEngineUnitAnimationStateData
---@field updateLook boolean
---@field updateAim boolean
---@field lookingBounds MetaEngineRectangle2DF
---@field aimingBounds MetaEngineRectangle2DF

---@class MetaEngineAiCommunicationPacket
---@field type string
---@field broken boolean

---@class MetaEngineUnitSpeech
---@field priority string
---@field screamType string
---@field soundTag integer
---@field ticks integer
---@field unknown2 integer
---@field unknown integer
---@field aiCommunicationInfo MetaEngineAiCommunicationPacket

---@class MetaEngineUnitSpeechData
---@field current MetaEngineUnitSpeech
---@field next MetaEngineUnitSpeech
---@field unknown0 integer
---@field unknown1 integer
---@field unknown2 integer
---@field unknown3 integer
---@field unknown4 integer
---@field unknown6 boolean
---@field unknown7 boolean
---@field unknown8 boolean
---@field unknown9 integer
---@field unknown10 integer
---@field unknown11 integer
---@field unknown12 integer
---@field unknown13 integer

---@class MetaEngineUnitRecentDamager
---@field lastDamageTime integer
---@field totalDamage number
---@field object integer
---@field player integer

---@class MetaEngineUnitControlData
---@field animationState integer
---@field aimingSpeed integer
---@field controlFlags MetaEngineUnitControlFlags
---@field weaponIndex integer
---@field grenadeIndex integer
---@field zoomIndex integer
---@field throttle MetaEngineVector3D
---@field primaryTrigger number
---@field facingVector MetaEngineVector3D
---@field aimingVector MetaEngineVector3D
---@field lookingVector MetaEngineVector3D

---@class MetaEngineUnitObject: MetaEngineBaseObject
---@field actor integer
---@field swarmActor integer
---@field swarmNextUnit integer
---@field swarmPreviousUnit integer
---@field unitFlags MetaEngineUnitFlags
---@field unitControlFlags MetaEngineUnitControlFlags
---@field shieldSnapping integer
---@field baseSeatIndex integer
---@field persistentControlTicksRemaining integer
---@field persistentControlControlFlags MetaEngineUnitControlFlags
---@field controllingPlayer integer
---@field aiEffectType integer
---@field emotionAnimationIndex integer
---@field nextAiEffectTick integer
---@field desiredFacingVector MetaEngineVector3D
---@field desiredAimingVector MetaEngineVector3D
---@field aimingVector MetaEngineVector3D
---@field aimingVelocity MetaEngineVector3D
---@field lookingAngles MetaEngineEuler3D
---@field lookingVector MetaEngineVector3D
---@field lookingVelocity MetaEngineVector3D
---@field throttle MetaEngineVector3D
---@field primaryTrigger number
---@field aimingSpeed integer
---@field meleeState integer
---@field meleeTimer integer
---@field ticksUntilFlameToDeath integer
---@field pingAnimationTicksLeft integer
---@field grenadeState string
---@field unknown725 integer
---@field unknown726 integer
---@field grenadeProjectile integer
---@field animation MetaEngineUnitAnimationData
---@field ambient number
---@field illumination number
---@field mouthFactor number
---@field vehicleSeatId integer
---@field currentWeaponId integer
---@field nextWeaponId integer
---@field weapons table<integer, integer>
---@field weaponReadyTicks table<integer, integer>
---@field equipmentHandle integer
---@field currentGrenadeIndex integer
---@field nextGrenadeIndex integer
---@field grenadeCounts table<integer, integer>
---@field zoomLevel integer
---@field desiredZoomLevel integer
---@field ticksSinceLastVehicleSpeech integer
---@field aimingChange integer
---@field poweredSeatsRiders table<integer, integer>
---@field unknown22 integer
---@field someTickTime integer
---@field encounterId integer
---@field squadId integer
---@field poweredSeatsPower table<integer, number>
---@field integratedLightPower number
---@field integratedLightTogglePower number
---@field integratedNightVisionTogglePower number
---@field seatRelated table<integer, MetaEngineVector3D>
---@field camoPower number
---@field fullSpectrumVisionPower number
---@field dialogueDefinition integer
---@field speech MetaEngineUnitSpeechData
---@field damageResultCategory string
---@field damageResultAiTicksUntilHandle integer
---@field damageResultAmount number
---@field damageResultResponsibleUnit integer
---@field objectFlameCauser integer
---@field unknown23 number
---@field diedAtTick integer
---@field feignDeathTimer integer
---@field camoRegrowth boolean
---@field stun number
---@field stunTicks integer
---@field spreeCount integer
---@field spreeStartingTime integer
---@field recentDamage table<integer, MetaEngineUnitRecentDamager>
---@field opensauceZoomLevel integer
---@field opensauceDesiredZoomLevel integer
---@field controlData MetaEngineUnitControlData
---@field lastCompletedClientUpdateValid boolean
---@field lastCompletedClientUpdateId integer

---@class MetaEngineBipedFlags
---@field airborne boolean
---@field slipping boolean
---@field absoluteMovement boolean
---@field noCollision boolean
---@field passesThroughOtherBipeds boolean
---@field limping2 boolean

---@alias BipedMovementState
---| 'moving'
---| 'idle'
---| 'gesturing'
---| 'unknown'

---@class MetaEngineBipedNetworkDelta
---@field grenadeCounts table<integer, number>
---@field bodyVitality number
---@field shieldVitality number
---@field shieldStunTicksGreaterThanZero boolean

---@class MetaEngineBipedNetwork
---@field baselineValid boolean
---@field baselineId integer
---@field messageId integer
---@field updateBaseline MetaEngineBipedNetworkDelta
---@field deltaValid boolean
---@field updateDelta MetaEngineBipedNetworkDelta

---@class MetaEngineBipedObject: MetaEngineUnitObject
---@field bipedFlags MetaEngineBipedFlags
---@field landingTimer integer
---@field landingForce integer
---@field movementState BipedMovementState
---@field bipedUnknown3 integer
---@field actionFlags integer
---@field bipedUnknown4 integer
---@field bipedPosition MetaEngineVector3D
---@field walkingCounter integer
---@field bumpObject integer
---@field ticksSinceLastBump integer
---@field airborneTicks integer
---@field slippingTicks integer
---@field digitalThrottle integer
---@field jumpTicks integer
---@field meleeTicks integer
---@field meleeInflictTicks integer
---@field unknownBiped2 integer
---@field crouchScale number
---@field unknownBiped1 number
---@field unknownBipedPhysicsRelated MetaEnginePlane3D
---@field network MetaEngineBipedNetwork

---@class MetaEngineVehicleFlags
---@field vehicleUnknown0 boolean
---@field hovering boolean
---@field crouched boolean
---@field jumping boolean
---@field unknownVehicle1 boolean
---@field unknownVehicle2 integer

---@class MetaEngineVehicleNetworkData
---@field atRest boolean
---@field position MetaEngineVector3D
---@field transitionalVelocity MetaEngineVector3D
---@field angularVelocity MetaEngineVector3D
---@field forward MetaEngineVector3D
---@field up MetaEngineVector3D

---@class MetaEngineVehicleNetwork
---@field timeValid boolean
---@field baselineValid boolean
---@field baselineId integer
---@field messageId integer
---@field updateBaseline MetaEngineVehicleNetworkData
---@field deltaValid boolean
---@field updateDelta MetaEngineVehicleNetworkData
---@field lastMovedAtTick integer
---@field scenarioRespawnId integer
---@field respawnPosition EngineVector3D

---@class MetaEngineVehicleObject
---@field vehicleFlags MetaEngineVehicleFlags
---@field speed number
---@field slide number
---@field turn number
---@field tirePosition number
---@field threadPositionLeft number
---@field threadPositionRight number
---@field hover number
---@field thrust number
---@field suspensionStates table<integer, integer>
---@field hoverPosition MetaEngineVector3D
---@field unknownVehicle3 MetaEngineVector3D
---@field unknownVehicle4 MetaEngineVector3D
---@field unknownVehicle5 integer
---@field network MetaEngineVehicleNetwork

---@class MetaEngineItemObject
---@field flags integer
---@field ticksUntilDetonation integer
---@field bspCollisionSurfaceId integer
---@field bspCollisionReferenceId integer
---@field droppedByUnit integer
---@field lastUpdateTick integer
---@field objectCollisionObject integer
---@field objectCollisionObjectPosition MetaEngineVector3D
---@field unknownCollisionPosition MetaEngineVector3D
---@field unknownCollisionAngle MetaEngineEuler2D

---@class MetaEngineWeaponTrigger
---@field idleTime integer
---@field state string
---@field triggerTime integer
---@field notFiring integer
---@field autoReload integer
---@field roundsSinceLastTracer integer
---@field rateOfFire number
---@field ejectionPortRecoveryTime number
---@field illuminationRecoveryTime number
---@field projectileErrorRelated number
---@field charingEffect integer
---@field networkDelayTicks integer

---@class MetaEngineWeaponMagazine
---@field state string
---@field reloadTicksRemaining integer
---@field reloadTicks integer
---@field roundsUnloaded integer
---@field roundsLoaded integer
---@field roundsLeftToRecharge integer
---@field unknown integer
---@field unknown2 integer

---@class MetaEngineWeaponReloadStartData
---@field totalRounds table<integer, integer>
---@field loadedRounds table<integer, integer>

---@class MetaEngineWeaponNetworkData
---@field position MetaEngineVector3D
---@field transitionalVelocity MetaEngineVector3D
---@field angularVelocity MetaEngineVector3D
---@field magazineRoundsTotal table<integer, number>
---@field age number

---@class MetaEngineWeaponNetwork
---@field baselineValid boolean
---@field baselineIndex integer
---@field messageIndex integer
---@field updateBaseline MetaEngineWeaponNetworkData
---@field deltaValid boolean
---@field updateDelta MetaEngineWeaponNetworkData

---@class MetaEngineWeaponObject
---@field flags integer
---@field ownerUnitFlags integer
---@field primaryTrigger number
---@field weaponState string
---@field readyTicks integer
---@field heat number
---@field age number
---@field illuminationFraction number
---@field integratedLightPower number
---@field trackedObject integer
---@field altShotsLoaded integer
---@field triggers table<integer, MetaEngineWeaponTrigger>
---@field magazines table<integer, MetaEngineWeaponMagazine>
---@field lastTriggerFireTick integer
---@field reloadStartingPoint MetaEngineWeaponReloadStartData
---@field network MetaEngineWeaponNetwork

---@class MetaEngineEquipmentNetworkData
---@field position MetaEngineVector3D
---@field transitionalVelocity MetaEngineVector3D
---@field angularVelocity MetaEngineVector3D

---@class MetaEngineEquipmentNetwork
---@field baselineValid boolean
---@field baselineIndex integer
---@field messageIndex integer
---@field updateBaseline MetaEngineEquipmentNetworkData
---@field deltaValid boolean
---@field updateDelta MetaEngineEquipmentNetworkData

---@class MetaEngineEquipmentObject
---@field network MetaEngineEquipmentNetwork

---@class MetaEngineGarbageObject
---@field ticksUntilGarbageCollection integer

---@class MetaEngineProjectileObjectFlags
---@field tracer boolean
---@field projectileUnknownBit boolean
---@field attached boolean

---@class MetaEngineProjectileNetworkData
---@field position MetaEngineVector3D
---@field transitionalVelocity MetaEngineVector3D

---@class MetaEngineProjectileNetwork
---@field unknown boolean
---@field baselineValid boolean
---@field baselineIndex integer
---@field messageIndex integer
---@field updateBaseline MetaEngineProjectileNetworkData
---@field deltaValid boolean
---@field updateDelta MetaEngineProjectileNetworkData

---@class MetaEngineProjectileObject
---@field projectileFlags MetaEngineProjectileObjectFlags
---@field actionEnum integer
---@field materialId integer
---@field sourceUnit integer
---@field targetObject integer
---@field contrailAttachmentBlockId integer
---@field timeRemaining number
---@field armingRate number
---@field unknownProjFloat1 number
---@field unknownProjFloat2 number
---@field distanceTravelled number
---@field transitionalVelocity MetaEngineVector3D
---@field waterDamageUpperBound number
---@field angularVelocity MetaEngineVector3D
---@field unknownEuler MetaEngineEuler2D
---@field network MetaEngineProjectileNetwork

---@class MetaEngineSceneryObject: MetaEngineBaseObject

---@class MetaEngineDeviceMachineObjectFlags
---@field doesNotOperateAutomatically boolean
---@field machineOneSided boolean
---@field neverAppearsLocked boolean
---@field openedByMeleeAttack boolean

---@class MetaEngineDeviceMachineObject
---@field deviceFlags MetaEngineDeviceMachineObjectFlags
---@field ticksSinceStartedOpening integer
---@field elevatorPosition MetaEngineVector3D

---@class MetaEngineDeviceControlObjectFlags
---@field usableFromBothSides boolean

---@class MetaEngineDeviceControlObject
---@field deviceControlFlags MetaEngineDeviceControlObjectFlags
---@field customNameId integer

---@class MetaEngineDeviceLightFixtureObject
---@field lightColor MetaEngineColorRGB
---@field lightIntensity number
---@field lightFalloffAngle number
---@field lightCutoffAngle number

---@class MetaEnginePlaceholderObject: MetaEngineBaseObject

---@class MetaEngineSoundSceneryObject: MetaEngineBaseObject

-- Get an object of the current game
---@param handle EngineObjectHandle|integer Handle of the object
---@param type EngineTagDataObjectType Type of the object
---@overload fun(handle: EngineObjectHandle|integer, type: EngineTagDataObjectTypeBiped): MetaEngineBipedObject?
---@overload fun(handle: EngineObjectHandle|integer, type: EngineTagDataObjectTypeVehicle): MetaEngineVehicleObject?
---@overload fun(handle: EngineObjectHandle|integer, type: EngineTagDataObjectTypeGarbage): MetaEngineGarbageObject?
---@overload fun(handle: EngineObjectHandle|integer, type: EngineTagDataObjectTypeWeapon): MetaEngineWeaponObject?
---@overload fun(handle: EngineObjectHandle|integer, type: EngineTagDataObjectTypeEquipment): MetaEngineEquipmentObject?
---@overload fun(handle: EngineObjectHandle|integer, type: EngineTagDataObjectTypeProjectile): MetaEngineProjectileObject?
---@overload fun(handle: EngineObjectHandle|integer, type: EngineTagDataObjectTypeDeviceMachine): MetaEngineDeviceMachineObject?
---@overload fun(handle: EngineObjectHandle|integer, type: EngineTagDataObjectTypeDeviceControl): MetaEngineDeviceControlObject?
---@overload fun(handle: EngineObjectHandle|integer, type: EngineTagDataObjectTypeDeviceLightFixture): MetaEngineDeviceLightFixtureObject?
---@return MetaEngineBaseObject?
function Engine.gameState.getObject(handle, type)
end

-- Spawn an object
---@param tagHandle EngineTagHandle|integer @The tag handle of the object
---@param parentObjectHandle? EngineObjectHandle|integer @The handle of the parent object
---@param position EnginePoint3D @The position of the object
---@return EngineObjectHandle @The handle of the object
function Engine.gameState.createObject(tagHandle, parentObjectHandle, position)
end

-- Delete the object
---@param objectHandle EngineObjectHandle|integer @The handle of the object
function Engine.gameState.deleteObject(objectHandle)
end

-- Make a unit enter a vehicle
---@param unitObjectHandle EngineObjectHandle|integer @The handle of the unit
---@param vehicleObjectHandle EngineObjectHandle|integer @The handle of the vehicle
---@param seatIndex integer @The index of the seat
function Engine.gameState.unitEnterVehicle(unitObjectHandle,
                                           vehicleObjectHandle,
                                           seatIndex)
end

---@alias EngineNetworkPlayerColor
---| 'white'
---| 'black'
---| 'red'
---| 'blue'
---| 'gray'
---| 'yellow'
---| 'green'
---| 'pink'
---| 'purple'
---| 'cyan'
---| 'cobalt'
---| 'orange'
---| 'teal'
---| 'sage'
---| 'brown'
---| 'tan'
---| 'maroon'
---| 'salmon'
---| 'unknown'

---@alias EnginePlayerObjectiveMode
---| 'race'
---| 'hill'
---| 'juggernaut'
---| 'ball'
---| 'none'
---| 'unknown'

---@class MetaEnginePlayerMultiplayerStatistics
---@field ctfFlagGrabs integer
---@field ctfFlagReturns integer
---@field ctfFlagScores integer
---@field oddballTargetKills integer
---@field oddballKills integer
---@field oddballUnknown integer
---@field kingHillScore integer
---@field raceTime integer
---@field raceLaps integer
---@field raceBestTime integer

---@class MetaEnginePlayer
---@field playerId integer
---@field localHandle integer
---@field name string
---@field unknownHandle integer
---@field team integer
---@field interactionObjectHandle integer
---@field interactionObjectType integer
---@field interactionObjectSeat integer
---@field respawnTime integer
---@field respawnTimeGrowth integer
---@field objectHandle integer
---@field prevObjectHandle integer
---@field bspClusterId integer
---@field weaponSwapResult boolean
---@field autoAimTargetObject integer
---@field lastFireTime integer
---@field name2 string
---@field color EngineNetworkPlayerColor
---@field iconIndex integer
---@field machineIndex integer
---@field controllerIndex integer
---@field team2 integer
---@field index integer
---@field invisibilityTime integer
---@field otherPowerupTimeLeft integer
---@field speed number
---@field teleporterFlagHandle integer
---@field objectiveMode EnginePlayerObjectiveMode
---@field objectivePlayerHandle integer
---@field targetPlayer integer
---@field targetTime integer
---@field lastDeathTime integer
---@field slayerTarget integer
---@field oddManOut boolean
---@field killStreak integer
---@field multikill integer
---@field lastKillTime integer
---@field kills table
---@field assists table
---@field betrays integer
---@field deaths integer
---@field suicides integer
---@field teamKills integer
---@field multiplayerStatistics MetaEnginePlayerMultiplayerStatistics
---@field telefragTimer integer
---@field quitTime integer
---@field telefragDanger boolean
---@field quit boolean
---@field ping integer
---@field teamKillCount integer
---@field teamKillTicksSinceLast integer
---@field position MetaEnginePoint3D
---@field melee boolean
---@field action boolean
---@field flashlight boolean
---@field reload boolean
---@field baselineUpdateXYAim number
---@field baselineUpdateZAim number
---@field baselineUpdateForward number
---@field baselineUpdateLeft number
---@field baselineUpdateRateOfFire number
---@field baselineUpdateWeaponSlot integer
---@field baselineUpdateGrenadeSlot integer
---@field updateAiming MetaEnginePoint3D
---@field updatePosition MetaEnginePoint3D

-- Get a player
---@param playerIndexOrHandle? EnginePlayerHandle|integer @The index or the handle of the player; If nil, the local player is returned
---@return MetaEnginePlayer @The player
function Engine.gameState.getPlayer(playerIndexOrHandle)
end

-- Get a player by their RCON handle
---@param playerRconHandle integer @The RCON handle of the player
---@return MetaEnginePlayer @The player
function Engine.gameState.getPlayerByRconHandle(playerRconHandle)
end

---@alias EngineCameraType
---| 'first_person'
---| 'vehicle'
---| 'cinematic'
---| 'debug'
---| 'unknown'

-- Get the camera type
---@return EngineCameraType
function Engine.core.getCameraType()
end

---@class EngineCameraData
---@field position EnginePoint3D
---@field orientation table<integer, EnginePoint3D>
---@field fov number

-- Get the camera data
---@return EngineCameraData
function Engine.core.getCameraData()
end

-------------------------------------------------------
-- Engine.hsc
-------------------------------------------------------

Engine.hsc = {}

-- Execute a script
---@param script string @The script to execute
function Engine.hsc.executeScript(script) end

-------------------------------------------------------
-- Engine.map
-------------------------------------------------------

Engine.map = {}

---@alias EngineCacheFileEngine
---| 'xbox'
---| 'demo'
---| 'retail'
---| 'custom'
---| 'invader'
---| 'demo compressed'
---| 'retail compressed'
---| 'custom compressed'
---| 'unknown'

---@alias EngineMapGameType
---| 'single_player'
---| 'multiplayer'
---| 'user_interface'

---@class EngineMapHeader
---@field engineType EngineCacheFileEngine
---@field fileSize integer
---@field tagDataOffset integer
---@field tagDataSize integer
---@field name string
---@field build string
---@field gameType EngineMapGameType
---@field crc32 integer

-- Get the map header of the currently loaded map
---@return EngineMapHeader
function Engine.map.getCurrentMapHeader()
end

-- Get the map list
---@return table<integer, string> @The map list
function Engine.map.getMapList()
end

-------------------------------------------------------
-- Engine.netgame
-------------------------------------------------------

Engine.netgame = {}

---@alias EngineNetworkGameServerType
---| 'none'
---| 'dedicated'
---| 'local'
---| 'unknown'

-- Get the server type
---@return EngineNetworkGameServerType
function Engine.netgame.getServerType()
end

---@alias EngineNetworkGameType
---| 'ctf'
---| 'slayer'
---| 'oddball'
---| 'king'
---| 'race'
---| 'none'

---@alias EngineNetworkGameMessageHudChatType
---| 'none'
---| 'all'
---| 'team'
---| 'vehicle'
---| 'unknown'

-- Get the server gametype
---@return EngineNetworkGameType @The server gametype
function Engine.netgame.getServerGametype()
end

-- Get if the current game is a team game
---@return boolean @If the current game is a team game
function Engine.netgame.currentGameIsTeam()
end

-------------------------------------------------------
-- Engine.tag
-------------------------------------------------------

Engine.tag = {}

---@class EngineTagDataHeader
---@field tagArrayAddress integer
---@field scenarioTagHandle integer 
---@field tagCount integer
---@field modelPartCount integer
---@field modelDataFileOffset integer
---@field vertexSize integer
---@field modelDataSize integer

-- Get the tag data header
---@return EngineTagDataHeader @The tag data header
function Engine.tag.getTagDataHeader()
end

---@alias EngineTagClass
---| EngineTagClassActor
---| EngineTagClassActorVariant
---| EngineTagClassAntenna
---| EngineTagClassModelAnimations
---| EngineTagClassBiped
---| EngineTagClassBitmap
---| EngineTagClassSpheroid
---| EngineTagClassContinuousDamageEffect
---| EngineTagClassModelCollisionGeometry
---| EngineTagClassColorTable
---| EngineTagClassContrail
---| EngineTagClassDeviceControl
---| EngineTagClassDecal
---| EngineTagClassUiWidgetDefinition
---| EngineTagClassInputDeviceDefaults
---| EngineTagClassDevice
---| EngineTagClassDetailObjectCollection
---| EngineTagClassEffect
---| EngineTagClassEquipment
---| EngineTagClassFlag
---| EngineTagClassFog
---| EngineTagClassFont
---| EngineTagClassMaterialEffects
---| EngineTagClassGarbage
---| EngineTagClassGlow
---| EngineTagClassGrenadeHudInterface
---| EngineTagClassHudMessageText
---| EngineTagClassHudNumber
---| EngineTagClassHudGlobals
---| EngineTagClassItem
---| EngineTagClassItemCollection
---| EngineTagClassDamageEffect
---| EngineTagClassLensFlare
---| EngineTagClassLightning
---| EngineTagClassDeviceLightFixture
---| EngineTagClassLight
---| EngineTagClassSoundLooping
---| EngineTagClassDeviceMachine
---| EngineTagClassGlobals
---| EngineTagClassMeter
---| EngineTagClassLightVolume
---| EngineTagClassGbxmodel
---| EngineTagClassModel
---| EngineTagClassMultiplayerScenarioDescription
---| EngineTagClassNull
---| EngineTagClassPreferencesNetworkGame
---| EngineTagClassObject
---| EngineTagClassParticle
---| EngineTagClassParticleSystem
---| EngineTagClassPhysics
---| EngineTagClassPlaceholder
---| EngineTagClassPointPhysics
---| EngineTagClassProjectile
---| EngineTagClassWeatherParticleSystem
---| EngineTagClassScenarioStructureBsp
---| EngineTagClassScenery
---| EngineTagClassShaderTransparentChicagoExtended
---| EngineTagClassShaderTransparentChicago
---| EngineTagClassScenario
---| EngineTagClassShaderEnvironment
---| EngineTagClassShaderTransparentGlass
---| EngineTagClassShader
---| EngineTagClassSky
---| EngineTagClassShaderTransparentMeter
---| EngineTagClassSound
---| EngineTagClassSoundEnvironment
---| EngineTagClassShaderModel
---| EngineTagClassShaderTransparentGeneric
---| EngineTagClassUiWidgetCollection
---| EngineTagClassShaderTransparentPlasma
---| EngineTagClassSoundScenery
---| EngineTagClassStringList
---| EngineTagClassShaderTransparentWater
---| EngineTagClassTagCollection
---| EngineTagClassCameraTrack
---| EngineTagClassDialogue
---| EngineTagClassUnitHudInterface
---| EngineTagClassUnit
---| EngineTagClassUnicodeStringList
---| EngineTagClassVirtualKeyboard
---| EngineTagClassVehicle
---| EngineTagClassWeapon
---| EngineTagClassWind
---| EngineTagClassWeaponHudInterface

---@class EngineTag
---@field primaryClass EngineTagClass
---@field secondaryClass EngineTagClass
---@field tertiaryClass EngineTagClass
---@field handle EngineTagHandle
---@field path string
---@field dataAddress integer
---@field indexed boolean

---@class TagBlock<T>: { count: integer, elements: T[] }

---@class MetaEngineTag: EngineTag

---@class MetaEngineActorTag: MetaEngineTag
---@field data MetaEngineTagDataActor

---@class MetaEngineActorVariantTag: MetaEngineTag
---@field data MetaEngineTagDataActorVariant

---@class MetaEngineAntennaTag: MetaEngineTag
---@field data MetaEngineTagDataAntenna

---@class MetaEngineModelAnimationsTag: MetaEngineTag
---@field data MetaEngineTagDataModelAnimations

---@class MetaEngineBipedTag: MetaEngineTag
---@field data MetaEngineTagDataBiped

---@class MetaEngineBitmapTag: MetaEngineTag
---@field data MetaEngineTagDataBitmap

---@class MetaEngineContinuousDamageEffectTag: MetaEngineTag
---@field data MetaEngineTagDataContinuousDamageEffect

---@class MetaEngineModelCollisionGeometryTag: MetaEngineTag
---@field data MetaEngineTagDataModelCollisionGeometry

---@class MetaEngineColorTableTag: MetaEngineTag
---@field data MetaEngineTagDataColorTable

---@class MetaEngineContrailTag: MetaEngineTag
---@field data MetaEngineTagDataContrail

---@class MetaEngineDeviceControlTag: MetaEngineTag
---@field data MetaEngineTagDataDeviceControl

---@class MetaEngineDecalTag: MetaEngineTag
---@field data MetaEngineTagDataDecal

---@class MetaEngineUiWidgetDefinitionTag: MetaEngineTag
---@field data MetaEngineTagDataUiWidgetDefinition

---@class MetaEngineInputDeviceDefaultsTag: MetaEngineTag
---@field data MetaEngineTagDataInputDeviceDefaults

---@class MetaEngineDeviceTag: MetaEngineTag
---@field data MetaEngineTagDataDevice

---@class MetaEngineDetailObjectCollectionTag: MetaEngineTag
---@field data MetaEngineTagDataDetailObjectCollection

---@class MetaEngineEffectTag: MetaEngineTag
---@field data MetaEngineTagDataEffect

---@class MetaEngineEquipmentTag: MetaEngineTag
---@field data MetaEngineTagDataEquipment

---@class MetaEngineFlagTag: MetaEngineTag
---@field data MetaEngineTagDataFlag

---@class MetaEngineFogTag: MetaEngineTag
---@field data MetaEngineTagDataFog

---@class MetaEngineFontTag: MetaEngineTag
---@field data MetaEngineTagDataFont

---@class MetaEngineLightningTag: MetaEngineTag
---@field data MetaEngineTagDataLightning

---@class MetaEngineMaterialEffectsTag: MetaEngineTag
---@field data MetaEngineTagDataMaterialEffects

---@class MetaEngineGarbageTag: MetaEngineTag
---@field data MetaEngineTagDataGarbage

---@class MetaEngineGlowTag: MetaEngineTag
---@field data MetaEngineTagDataGlow

---@class MetaEngineGrenadeHudInterfaceTag: MetaEngineTag
---@field data MetaEngineTagDataGrenadeHudInterface

---@class MetaEngineHudMessageTextTag: MetaEngineTag
---@field data MetaEngineTagDataHudMessageText

---@class MetaEngineHudNumberTag: MetaEngineTag
---@field data MetaEngineTagDataHudNumber

---@class MetaEngineHudGlobalsTag: MetaEngineTag
---@field data MetaEngineTagDataHudGlobals

---@class MetaEngineItemTag: MetaEngineTag
---@field data MetaEngineTagDataItem

---@class MetaEngineItemCollectionTag: MetaEngineTag
---@field data MetaEngineTagDataItemCollection

---@class MetaEngineDamageEffectTag: MetaEngineTag
---@field data MetaEngineTagDataDamageEffect

---@class MetaEngineLensFlareTag: MetaEngineTag
---@field data MetaEngineTagDataLensFlare

---@class MetaEngineDeviceLightFixtureTag: MetaEngineTag
---@field data MetaEngineTagDataDeviceLightFixture

---@class MetaEngineLightTag: MetaEngineTag
---@field data MetaEngineTagDataLight

---@class MetaEngineSoundLoopingTag: MetaEngineTag
---@field data MetaEngineTagDataSoundLooping

---@class MetaEngineDeviceMachineTag: MetaEngineTag
---@field data MetaEngineTagDataDeviceMachine

---@class MetaEngineGlobalsTag: MetaEngineTag
---@field data MetaEngineTagDataGlobals

---@class MetaEngineMeterTag: MetaEngineTag
---@field data MetaEngineTagDataMeter

---@class MetaEngineLightVolumeTag: MetaEngineTag
---@field data MetaEngineTagDataLightVolume

---@class MetaEngineGbxmodelTag: MetaEngineTag
---@field data MetaEngineTagDataGbxmodel

---@class MetaEngineModelTag: MetaEngineTag
---@field data MetaEngineTagDataModel

---@class MetaEngineMultiplayerScenarioDescriptionTag: MetaEngineTag
---@field data MetaEngineTagDataMultiplayerScenarioDescription

---@class MetaEnginePreferencesNetworkGameTag: MetaEngineTag
---@field data MetaEngineTagDataPreferencesNetworkGame

---@class MetaEngineObjectTag: MetaEngineTag
---@field data MetaEngineTagDataObject

---@class MetaEngineParticleTag: MetaEngineTag
---@field data MetaEngineTagDataParticle

---@class MetaEngineParticleSystemTag: MetaEngineTag
---@field data MetaEngineTagDataParticleSystem

---@class MetaEnginePhysicsTag: MetaEngineTag
---@field data MetaEngineTagDataPhysics

---@class MetaEnginePlaceholderTag: MetaEngineTag
---@field data MetaEngineTagDataPlaceholder

---@class MetaEnginePointPhysicsTag: MetaEngineTag
---@field data MetaEngineTagDataPointPhysics

---@class MetaEngineProjectileTag: MetaEngineTag
---@field data MetaEngineTagDataProjectile

---@class MetaEngineWeatherParticleSystemTag: MetaEngineTag
---@field data MetaEngineTagDataWeatherParticleSystem

---@class MetaEngineScenarioStructureBspTag: MetaEngineTag
---@field data MetaEngineTagDataScenarioStructureBsp

---@class MetaEngineSceneryTag: MetaEngineTag
---@field data MetaEngineTagDataScenery

---@class MetaEngineShaderTransparentChicagoExtendedTag: MetaEngineTag
---@field data MetaEngineTagDataShaderTransparentChicagoExtended

---@class MetaEngineShaderTransparentChicagoTag: MetaEngineTag
---@field data MetaEngineTagDataShaderTransparentChicago

---@class MetaEngineScenarioTag: MetaEngineTag
---@field data MetaEngineTagDataScenario

---@class MetaEngineShaderEnvironmentTag: MetaEngineTag
---@field data MetaEngineTagDataShaderEnvironment

---@class MetaEngineShaderTransparentGlassTag: MetaEngineTag
---@field data MetaEngineTagDataShaderTransparentGlass

---@class MetaEngineShaderTag: MetaEngineTag
---@field data MetaEngineTagDataShader

---@class MetaEngineSkyTag: MetaEngineTag
---@field data MetaEngineTagDataSky

---@class MetaEngineShaderTransparentMeterTag: MetaEngineTag
---@field data MetaEngineTagDataShaderTransparentMeter

---@class MetaEngineSoundTag: MetaEngineTag
---@field data MetaEngineTagDataSound

---@class MetaEngineSoundEnvironmentTag: MetaEngineTag
---@field data MetaEngineTagDataSoundEnvironment

---@class MetaEngineShaderModelTag: MetaEngineTag
---@field data MetaEngineTagDataShaderModel

---@class MetaEngineShaderTransparentGenericTag: MetaEngineTag
---@field data MetaEngineTagDataShaderTransparentGeneric

---@class MetaEngineTagDataUiWidgetCollection: MetaEngineTagDataTagCollection



---@class MetaEngineUiWidgetCollectionTag: MetaEngineTag
---@field data MetaEngineTagDataUiWidgetCollection

---@class MetaEngineShaderTransparentPlasmaTag: MetaEngineTag
---@field data MetaEngineTagDataShaderTransparentPlasma

---@class MetaEngineSoundSceneryTag: MetaEngineTag
---@field data MetaEngineTagDataSoundScenery

---@class MetaEngineStringListTag: MetaEngineTag
---@field data MetaEngineTagDataStringList

---@class MetaEngineShaderTransparentWaterTag: MetaEngineTag
---@field data MetaEngineTagDataShaderTransparentWater

---@class MetaEngineTagCollectionTag: MetaEngineTag
---@field data MetaEngineTagDataTagCollection

---@class MetaEngineCameraTrackTag: MetaEngineTag
---@field data MetaEngineTagDataCameraTrack

---@class MetaEngineUnitHudInterfaceTag: MetaEngineTag
---@field data MetaEngineTagDataUnitHudInterface

---@class MetaEngineUnitTag: MetaEngineTag
---@field data MetaEngineTagDataUnit

---@class MetaEngineUnicodeStringListTag: MetaEngineTag
---@field data MetaEngineTagDataUnicodeStringList

---@class MetaEngineVirtualKeyboardTag: MetaEngineTag
---@field data MetaEngineTagDataVirtualKeyboard

---@class MetaEngineVehicleTag: MetaEngineTag
---@field data MetaEngineTagDataVehicle

---@class MetaEngineWeaponTag: MetaEngineTag
---@field data MetaEngineTagDataWeapon

---@class MetaEngineWindTag: MetaEngineTag
---@field data MetaEngineTagDataWind

---@class MetaEngineWeaponHudInterfaceTag: MetaEngineTag
---@field data MetaEngineTagDataWeaponHudInterface

---@class EngineTagClassEnum : Enum

---@class EngineTagClassActor : EngineTagClassEnum
---@class EngineTagClassActorVariant : EngineTagClassEnum
---@class EngineTagClassAntenna : EngineTagClassEnum
---@class EngineTagClassModelAnimations : EngineTagClassEnum
---@class EngineTagClassBiped : EngineTagClassEnum
---@class EngineTagClassBitmap : EngineTagClassEnum
---@class EngineTagClassSpheroid : EngineTagClassEnum
---@class EngineTagClassContinuousDamageEffect : EngineTagClassEnum
---@class EngineTagClassModelCollisionGeometry : EngineTagClassEnum
---@class EngineTagClassColorTable : EngineTagClassEnum
---@class EngineTagClassContrail : EngineTagClassEnum
---@class EngineTagClassDeviceControl : EngineTagClassEnum
---@class EngineTagClassDecal : EngineTagClassEnum
---@class EngineTagClassUiWidgetDefinition : EngineTagClassEnum
---@class EngineTagClassInputDeviceDefaults : EngineTagClassEnum
---@class EngineTagClassDevice : EngineTagClassEnum
---@class EngineTagClassDetailObjectCollection : EngineTagClassEnum
---@class EngineTagClassEffect : EngineTagClassEnum
---@class EngineTagClassEquipment : EngineTagClassEnum
---@class EngineTagClassFlag : EngineTagClassEnum
---@class EngineTagClassFog : EngineTagClassEnum
---@class EngineTagClassFont : EngineTagClassEnum
---@class EngineTagClassMaterialEffects : EngineTagClassEnum
---@class EngineTagClassGarbage : EngineTagClassEnum
---@class EngineTagClassGlow : EngineTagClassEnum
---@class EngineTagClassGrenadeHudInterface : EngineTagClassEnum
---@class EngineTagClassHudMessageText : EngineTagClassEnum
---@class EngineTagClassHudNumber : EngineTagClassEnum
---@class EngineTagClassHudGlobals : EngineTagClassEnum
---@class EngineTagClassItem : EngineTagClassEnum
---@class EngineTagClassItemCollection : EngineTagClassEnum
---@class EngineTagClassDamageEffect : EngineTagClassEnum
---@class EngineTagClassLensFlare : EngineTagClassEnum
---@class EngineTagClassLightning : EngineTagClassEnum
---@class EngineTagClassDeviceLightFixture : EngineTagClassEnum
---@class EngineTagClassLight : EngineTagClassEnum
---@class EngineTagClassSoundLooping : EngineTagClassEnum
---@class EngineTagClassDeviceMachine : EngineTagClassEnum
---@class EngineTagClassGlobals : EngineTagClassEnum
---@class EngineTagClassMeter : EngineTagClassEnum
---@class EngineTagClassLightVolume : EngineTagClassEnum
---@class EngineTagClassGbxmodel : EngineTagClassEnum
---@class EngineTagClassModel : EngineTagClassEnum
---@class EngineTagClassMultiplayerScenarioDescription : EngineTagClassEnum
---@class EngineTagClassNull : EngineTagClassEnum
---@class EngineTagClassPreferencesNetworkGame : EngineTagClassEnum
---@class EngineTagClassObject : EngineTagClassEnum
---@class EngineTagClassParticle : EngineTagClassEnum
---@class EngineTagClassParticleSystem : EngineTagClassEnum
---@class EngineTagClassPhysics : EngineTagClassEnum
---@class EngineTagClassPlaceholder : EngineTagClassEnum
---@class EngineTagClassPointPhysics : EngineTagClassEnum
---@class EngineTagClassProjectile : EngineTagClassEnum
---@class EngineTagClassWeatherParticleSystem : EngineTagClassEnum
---@class EngineTagClassScenarioStructureBsp : EngineTagClassEnum
---@class EngineTagClassScenery : EngineTagClassEnum
---@class EngineTagClassShaderTransparentChicagoExtended : EngineTagClassEnum
---@class EngineTagClassShaderTransparentChicago : EngineTagClassEnum
---@class EngineTagClassScenario : EngineTagClassEnum
---@class EngineTagClassShaderEnvironment : EngineTagClassEnum
---@class EngineTagClassShaderTransparentGlass : EngineTagClassEnum
---@class EngineTagClassShader : EngineTagClassEnum
---@class EngineTagClassSky : EngineTagClassEnum
---@class EngineTagClassShaderTransparentMeter : EngineTagClassEnum
---@class EngineTagClassSound : EngineTagClassEnum
---@class EngineTagClassSoundEnvironment : EngineTagClassEnum
---@class EngineTagClassShaderModel : EngineTagClassEnum
---@class EngineTagClassShaderTransparentGeneric : EngineTagClassEnum
---@class EngineTagClassUiWidgetCollection : EngineTagClassEnum
---@class EngineTagClassShaderTransparentPlasma : EngineTagClassEnum
---@class EngineTagClassSoundScenery : EngineTagClassEnum
---@class EngineTagClassStringList : EngineTagClassEnum
---@class EngineTagClassShaderTransparentWater : EngineTagClassEnum
---@class EngineTagClassTagCollection : EngineTagClassEnum
---@class EngineTagClassCameraTrack : EngineTagClassEnum
---@class EngineTagClassDialogue : EngineTagClassEnum
---@class EngineTagClassUnitHudInterface : EngineTagClassEnum
---@class EngineTagClassUnit : EngineTagClassEnum
---@class EngineTagClassUnicodeStringList : EngineTagClassEnum
---@class EngineTagClassVirtualKeyboard : EngineTagClassEnum
---@class EngineTagClassVehicle : EngineTagClassEnum
---@class EngineTagClassWeapon : EngineTagClassEnum
---@class EngineTagClassWind : EngineTagClassEnum
---@class EngineTagClassWeaponHudInterface : EngineTagClassEnum

---@class EngineTagClassesTable
---@field actor EngineTagClassActor
---@field actorVariant EngineTagClassActorVariant
---@field antenna EngineTagClassAntenna
---@field modelAnimations EngineTagClassModelAnimations
---@field biped EngineTagClassBiped
---@field bitmap EngineTagClassBitmap
---@field spheroid EngineTagClassSpheroid
---@field continuousDamageEffect EngineTagClassContinuousDamageEffect
---@field modelCollisionGeometry EngineTagClassModelCollisionGeometry
---@field colorTable EngineTagClassColorTable
---@field contrail EngineTagClassContrail
---@field deviceControl EngineTagClassDeviceControl
---@field decal EngineTagClassDecal
---@field uiWidgetDefinition EngineTagClassUiWidgetDefinition
---@field inputDeviceDefaults EngineTagClassInputDeviceDefaults
---@field device EngineTagClassDevice
---@field detailObjectCollection EngineTagClassDetailObjectCollection
---@field effect EngineTagClassEffect
---@field equipment EngineTagClassEquipment
---@field flag EngineTagClassFlag
---@field fog EngineTagClassFog
---@field font EngineTagClassFont
---@field materialEffects EngineTagClassMaterialEffects
---@field garbage EngineTagClassGarbage
---@field glow EngineTagClassGlow
---@field grenadeHudInterface EngineTagClassGrenadeHudInterface
---@field hudMessageText EngineTagClassHudMessageText
---@field hudNumber EngineTagClassHudNumber
---@field hudGlobals EngineTagClassHudGlobals
---@field item EngineTagClassItem
---@field itemCollection EngineTagClassItemCollection
---@field damageEffect EngineTagClassDamageEffect
---@field lensFlare EngineTagClassLensFlare
---@field lightning EngineTagClassLightning
---@field deviceLightFixture EngineTagClassDeviceLightFixture
---@field light EngineTagClassLight
---@field soundLooping EngineTagClassSoundLooping
---@field deviceMachine EngineTagClassDeviceMachine
---@field globals EngineTagClassGlobals
---@field meter EngineTagClassMeter
---@field lightVolume EngineTagClassLightVolume
---@field gbxmodel EngineTagClassGbxmodel
---@field model EngineTagClassModel
---@field multiplayerScenarioDescription EngineTagClassMultiplayerScenarioDescription
---@field null EngineTagClassNull
---@field preferencesNetworkGame EngineTagClassPreferencesNetworkGame
---@field object EngineTagClassObject
---@field particle EngineTagClassParticle
---@field particleSystem EngineTagClassParticleSystem
---@field physics EngineTagClassPhysics
---@field placeholder EngineTagClassPlaceholder
---@field pointPhysics EngineTagClassPointPhysics
---@field projectile EngineTagClassProjectile
---@field weatherParticleSystem EngineTagClassWeatherParticleSystem
---@field scenarioStructureBsp EngineTagClassScenarioStructureBsp
---@field scenery EngineTagClassScenery
---@field shaderTransparentChicagoExtended EngineTagClassShaderTransparentChicagoExtended
---@field shaderTransparentChicago EngineTagClassShaderTransparentChicago
---@field scenario EngineTagClassScenario
---@field shaderEnvironment EngineTagClassShaderEnvironment
---@field shaderTransparentGlass EngineTagClassShaderTransparentGlass
---@field shader EngineTagClassShader
---@field sky EngineTagClassSky
---@field shaderTransparentMeter EngineTagClassShaderTransparentMeter
---@field sound EngineTagClassSound
---@field soundEnvironment EngineTagClassSoundEnvironment
---@field shaderModel EngineTagClassShaderModel
---@field shaderTransparentGeneric EngineTagClassShaderTransparentGeneric
---@field uiWidgetCollection EngineTagClassUiWidgetCollection
---@field shaderTransparentPlasma EngineTagClassShaderTransparentPlasma
---@field soundScenery EngineTagClassSoundScenery
---@field stringList EngineTagClassStringList
---@field shaderTransparentWater EngineTagClassShaderTransparentWater
---@field tagCollection EngineTagClassTagCollection
---@field cameraTrack EngineTagClassCameraTrack
---@field dialogue EngineTagClassDialogue
---@field unitHudInterface EngineTagClassUnitHudInterface
---@field unit EngineTagClassUnit
---@field unicodeStringList EngineTagClassUnicodeStringList
---@field virtualKeyboard EngineTagClassVirtualKeyboard
---@field vehicle EngineTagClassVehicle
---@field weapon EngineTagClassWeapon
---@field wind EngineTagClassWind
---@field weaponHudInterface EngineTagClassWeaponHudInterface
Engine.tag.classes = {} 

-- Get a tag
---@param tagHandleOrPath EngineTagHandle|integer @The handle or path of the tag
---@param tagClass? EngineTagClass @The class of the tag; If first argument is a handle, this argument can be skipped
---@return MetaEngineTag|nil @The tag; nil if not found
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassActor): MetaEngineActorTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassActorVariant): MetaEngineActorVariantTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassAntenna): MetaEngineAntennaTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassModelAnimations): MetaEngineModelAnimationsTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassBiped): MetaEngineBipedTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassBitmap): MetaEngineBitmapTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassContinuousDamageEffect): MetaEngineContinuousDamageEffectTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassModelCollisionGeometry): MetaEngineModelCollisionGeometryTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassColorTable): MetaEngineColorTableTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassContrail): MetaEngineContrailTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassDeviceControl): MetaEngineDeviceControlTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassDecal): MetaEngineDecalTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassUiWidgetDefinition): MetaEngineUiWidgetDefinitionTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassInputDeviceDefaults): MetaEngineInputDeviceDefaultsTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassDevice): MetaEngineDeviceTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassDetailObjectCollection): MetaEngineDetailObjectCollectionTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassEffect): MetaEngineEffectTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassEquipment): MetaEngineEquipmentTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassFlag): MetaEngineFlagTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassFog): MetaEngineFogTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassFont): MetaEngineFontTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassLightning): MetaEngineLightningTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassMaterialEffects): MetaEngineMaterialEffectsTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassGarbage): MetaEngineGarbageTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassGlow): MetaEngineGlowTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassGrenadeHudInterface): MetaEngineGrenadeHudInterfaceTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassHudMessageText): MetaEngineHudMessageTextTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassHudNumber): MetaEngineHudNumberTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassHudGlobals): MetaEngineHudGlobalsTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassItem): MetaEngineItemTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassItemCollection): MetaEngineItemCollectionTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassDamageEffect): MetaEngineDamageEffectTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassLensFlare): MetaEngineLensFlareTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassDeviceLightFixture): MetaEngineDeviceLightFixtureTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassLight): MetaEngineLightTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassSoundLooping): MetaEngineSoundLoopingTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassDeviceMachine): MetaEngineDeviceMachineTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassGlobals): MetaEngineGlobalsTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassMeter): MetaEngineMeterTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassLightVolume): MetaEngineLightVolumeTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassGbxmodel): MetaEngineGbxmodelTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassModel): MetaEngineModelTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassMultiplayerScenarioDescription): MetaEngineMultiplayerScenarioDescriptionTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassPreferencesNetworkGame): MetaEnginePreferencesNetworkGameTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassObject): MetaEngineObjectTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassParticle): MetaEngineParticleTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassParticleSystem): MetaEngineParticleSystemTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassPhysics): MetaEnginePhysicsTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassPlaceholder): MetaEnginePlaceholderTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassPointPhysics): MetaEnginePointPhysicsTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassProjectile): MetaEngineProjectileTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassWeatherParticleSystem): MetaEngineWeatherParticleSystemTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassScenarioStructureBsp): MetaEngineScenarioStructureBspTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassScenery): MetaEngineSceneryTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassShaderTransparentChicagoExtended): MetaEngineShaderTransparentChicagoExtendedTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassShaderTransparentChicago): MetaEngineShaderTransparentChicagoTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassScenario): MetaEngineScenarioTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassShaderEnvironment): MetaEngineShaderEnvironmentTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassShaderTransparentGlass): MetaEngineShaderTransparentGlassTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassShader): MetaEngineShaderTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassSky): MetaEngineSkyTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassShaderTransparentMeter): MetaEngineShaderTransparentMeterTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassSound): MetaEngineSoundTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassSoundEnvironment): MetaEngineSoundEnvironmentTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassShaderModel): MetaEngineShaderModelTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassShaderTransparentGeneric): MetaEngineShaderTransparentGenericTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassUiWidgetCollection): MetaEngineUiWidgetCollectionTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassShaderTransparentPlasma): MetaEngineShaderTransparentPlasmaTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassSoundScenery): MetaEngineSoundSceneryTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassStringList): MetaEngineStringListTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassShaderTransparentWater): MetaEngineShaderTransparentWaterTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassTagCollection): MetaEngineTagCollectionTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassCameraTrack): MetaEngineCameraTrackTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassUnitHudInterface): MetaEngineUnitHudInterfaceTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassUnit): MetaEngineUnitTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassUnicodeStringList): MetaEngineUnicodeStringListTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassVirtualKeyboard): MetaEngineVirtualKeyboardTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassVehicle): MetaEngineVehicleTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassWeapon): MetaEngineWeaponTag |nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassWind): MetaEngineWindTag|nil
---@overload fun(tagHandleOrPath: string|integer|EngineTagHandle, tagClass: EngineTagClassWeaponHudInterface): MetaEngineWeaponHudInterfaceTag|nil
function Engine.tag.getTag(tagHandleOrPath, tagClass)
end

---Return a tag entry list given a keyword and/or a tag class
---
---Leave the keyword empty to get all tags, if tag class is nil, it will return all tags
---@param keyword string @Keyword to search for
---@param tagClass? EngineTagClass Class of the tag
function Engine.tag.findTags(keyword, tagClass)
end
-------------------------------------------------------
-- Engine.userInterface
-------------------------------------------------------

Engine.userInterface = {}

---@class EngineWidget
---@field definitionTagHandle EngineTagHandle
---@field name string
---@field controllerIndex boolean
---@field position EnginePoint2DInt
---@field type EngineTagDataUIWidgetType
---@field visible boolean
---@field renderRegardlessOfControllerIndex boolean
---@field pausesGameTime boolean
---@field deleted boolean
---@field creationProcessStartTime integer
---@field msToClose integer
---@field msToCloseFadeTime integer
---@field opacity number
---@field previousWidget MetaEngineWidget|nil
---@field nextWidget MetaEngineWidget|nil
---@field parentWidget MetaEngineWidget|nil
---@field childWidget MetaEngineWidget|nil
---@field focusedChild MetaEngineWidget|nil
---@field textAddress integer @The address of the text; nil if the widget is not a text widget, be careful!
---@field cursorIndex integer @Index of the last child widget focused by the mouse
---@field extendedDescriptionWidget EngineWidget
---@field bitmapIndex integer

---@class MetaEngineWidget: EngineWidget

---@class EngineInputBufferedKeyModifierEnum : Enum
---@class EngineInputBufferedKeyModifierAlt : EngineInputBufferedKeyModifierEnum
---@class EngineInputBufferedKeyModifierCtrl : EngineInputBufferedKeyModifierEnum
---@class EngineInputBufferedKeyModifierShift : EngineInputBufferedKeyModifierEnum

---@alias EngineInputBufferedModifier
---| EngineInputBufferedKeyModifierAlt
---| EngineInputBufferedKeyModifierCtrl
---| EngineInputBufferedKeyModifierShift

---@class EngineInputBufferedKeyEnumTable
---@field alt EngineInputBufferedKeyModifierAlt
---@field ctrl EngineInputBufferedKeyModifierCtrl
---@field shift EngineInputBufferedKeyModifierShift

---@class EngineInputBufferedKey 
---@field modifier EngineInputBufferedModifier
---@field character integer
---@field keycode integer

---@alias EngineWidgetNavigationSound
---| 'cursor'
---| 'forward'
---| 'back'
---| 'flag_failure'

-- Find a widget from a given widget definition; it only returns the first coincidence
---@param widgetDefinition integer|string|EngineTagHandle @The handle or path of the widget definition
---@param baseWidget? MetaEngineWidget @The base widget to start the search from; If nil, the search will start from the root widget
---@return MetaEngineWidget|nil @Found widget; nil if not found
function Engine.userInterface.findWidget(widgetDefinition, baseWidget)
end

-- Find all widgets from a given widget definition
---@param widgetDefinition integer|string|EngineTagHandle @The handle or path of the widget definition
---@param baseWidget? MetaEngineWidget @The base widget to start the search from; If nil, the search will start from the root widget
---@return table<integer, MetaEngineWidget>|nil @Found widgets; nil if any widget was found
function Engine.userInterface.findWidgets(widgetDefinition, baseWidget)
end

-- Open a widget
---@param widgetDefinition integer|string|EngineTagHandle @The handle or path of the widget definition
---@param pushHistory? boolean @If the widget should be pushed to the history; false by default
---@return MetaEngineWidget|nil @Created widget; nil if failed
function Engine.userInterface.openWidget(widgetDefinition, pushHistory)
end

-- Close current root widget; return to the previous one in history
function Engine.userInterface.closeWidget()
end

-- Replace a widget
---@param targetWidget MetaEngineWidget @The widget to replace
---@param widgetDefinition integer|string|EngineTagHandle @The handle or path of the widget definition
---@return MetaEngineWidget|nil @Created widget; nil if failed
function Engine.userInterface.replaceWidget(targetWidget, widgetDefinition)
end

-- Reload a widget; replaces the widget with a new one with the same definition and state 
---@param targetWidget MetaEngineWidget @The widget to reload
---@return MetaEngineWidget|nil @New widget; nil if failed
function Engine.userInterface.reloadWidget(targetWidget)
end

-- Focus a widget
---@param targetWidget MetaEngineWidget @The widget to focus
function Engine.userInterface.focusWidget(targetWidget)
end

-- Get the current root widget
---@return MetaEngineWidget @The current root widget
function Engine.userInterface.getRootWidget()
end

-- Get the current root widget
---@return MetaEngineWidget @The current root widget
function Engine.userInterface.getRootWidget() end

-- Open the pause menu
function Engine.userInterface.openPauseMenu()
end

-- Gets the HUD globals tag data
---@return MetaEngineTagDataHudGlobals @The HUD globals tag data of the current map
function Engine.userInterface.getHudGlobals()
end

-- Gets the size of a sprite in a bitmap
---@param bitmap MetaEngineTagDataBitmap @Bitmap data
---@param sequenceIndex integer @A valid sequence index of the bitmap
---@param spriteIndex integer @A valid sprite index of the bitmap
---@return EngineResolution|nil @The size of the sprite; nil if failed
function Engine.userInterface.getBitmapSpriteResolution(bitmap, sequenceIndex, spriteIndex)
end

-- Draws a icon bitmap on a HUD message.
---@param bitmap MetaEngineTagDataBitmap @Bitmap data
---@param sequenceIndex integer @A valid sequence index of the bitmap
---@param spriteIndex integer @A valid sprite index of the bitmap
---@param position EnginePoint2D @The position of the sprite
---@param color EngineColorARGBInt @The color of the sprite
function Engine.userInterface.drawHudMessageSprite(bitmap,
                                                   sequenceIndex,
                                                   spriteIndex,
                                                   position,
                                                   color)
end

-- Play a sound from a given tag
---@param soundTagHandleOrPath integer|string|EngineTagHandle @The handle or path of the sound tag
function Engine.userInterface.playSound(soundTagHandleOrPath)
end

-- Get the duration of a sound permutation
---@param soundPermutation MetaEngineTagDataSoundPermutation @The sound permutation
function Engine.userInterface.getSoundPermutationSamplesDuration(soundPermutation)
end

-------------------------------------------------------
-- Engine.renderer
-------------------------------------------------------

---@class EngineResolution
---@field height integer
---@field width integer

-- Get the current resolution of the game
---@return EngineResolution
function Engine.core.getResolution()
end
