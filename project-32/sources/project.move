module MyModule::TimeTracking {

    use aptos_framework::signer;
    use aptos_framework::coin;
    use aptos_framework::aptos_coin::AptosCoin;
    use std::vector;

    /// Struct representing tracked work for a freelancer.
    struct WorkLog has store, key {
        worker: address,        // Address of the worker
        hours_logged: u64,      // Number of hours worked
        hourly_rate: u64,       // Hourly payment rate in tokens
        is_paid: bool,          // Whether the logged hours have been paid
    }

    /// Function for a worker to log their work hours.
    public fun log_work(worker: &signer, hours: u64, hourly_rate: u64) {
        let work_log = WorkLog {
            worker: signer::address_of(worker),
            hours_logged: hours,
            hourly_rate,
            is_paid: false,
        };
        move_to(worker, work_log);
    }

    /// Function to pay the worker for the logged hours.
    public fun pay_worker(client: &signer, worker_address: address) acquires WorkLog {
        let work_log = borrow_global_mut<WorkLog>(worker_address);

        // Ensure the hours have not already been paid
        assert!(!work_log.is_paid, 1);

        // Calculate total payment
        let total_payment = work_log.hours_logged * work_log.hourly_rate;

        // Mark the work as paid
        work_log.is_paid = true;

        
    }
}
