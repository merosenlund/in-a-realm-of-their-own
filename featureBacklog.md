# Feature Backlog: In a Realm of Their Own

## Core Mechanics: Voxel & Movement
- **Precise Mining**: Selection outline for the block being looked at.
- **Dynamic Gravity**: Potential for different gravity in different realms.
- **Infinite Cubic Chunks**: (Future Tech) Moving from GridMap to custom mesh generation for infinite height/depth.

## The Mana System (Core-Centric)
### 1. The Realm Core
- A floating orb at the center of the realm.
- Automatically condenses "Ambient Mana" from the atmosphere into a global pool.
- Can be upgraded later to increase condensation speed.

### 2. Gaseous Mana
- **Collection**: Harvested from the air or through "Vent" blocks.
- **Transport**: Standard low-pressure pipes.
- **Usage**: Low-level lighting, basic expansion speed buffs.
- **Density**: Lowest.

### 3. Liquid Mana
- **Creation**: Requires a **Liquifier** machine.
- **Transport**: High-pressure pipes; prone to leaks or "evaporation" if not managed.
- **Conversion**: Must be converted back to Gas (via an Evaporator) to be used by early-game machines.
- **Density**: Medium.

### 4. Solid Mana
- **Creation**: Requires a **Solidifier** (Complex structure).
- **Transport**: Manual carrying or **Conveyor Belts**.
- **Conversion**: Extremely slow to revert to liquid/gas, but produces massive energy spikes.
- **Density**: Highest.

## Realm Mechanics
- **Expansion Radius**: Current autonomous growth mechanic.
- **Mana-Infused Growth**: Spending Gas to "pulse" the radius for instant land generation.
- **Resource Shards**: Temporary realms for focused gathering (Forest, Mining, Void).

## The Market & Economics
- **The Store**: A global UI where mana can be spent to purchase blocks or items.
- **Purchasing vs. Crafting**: Items in the store are more expensive than manually crafting them.
- **Mana-to-Matter**: The core can "manifest" blocks directly into your inventory for a cost.

## Structures & Machines
- **The Teleporter**: The gateway to other realms.
- **Deconstructor**: (Future) A machine that breaks blocks back down into raw Mana.
- **Expansion Beacon**: Increases the chance of high-value blocks spawning in the growth radius.

## UI/UX
- **Mana HUD**: Multi-state gauges (Gas/Liquid/Solid counts).
- **Realm Map**: Visualizing your growth radius and points of interest.
- **Crosshair Feedback**: Changing color or shape based on what you are interacting with.
