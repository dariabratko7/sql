using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Linq;

namespace ShopDatabase
{
    public class Phone
    {
        public int Id { get; set; }
        public string Manufacturer { get; set; }
        public string Model { get; set; }
        public int Year { get; set; }
        public decimal Price { get; set; }
    }

    public class ShopContext : DbContext
    {
        private readonly string _connectionString;

        public ShopContext(string connectionString)
        {
            _connectionString = connectionString;
        }

        public DbSet<Phone> Phones { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            optionsBuilder.UseSqlServer(_connectionString);
        }
    }

    class Program
    {
        static void Main(string[] args)
        {
            IConfiguration configuration = new ConfigurationBuilder()
                .SetBasePath(AppDomain.CurrentDomain.BaseDirectory)
                .AddJsonFile("appsettings.json")
                .Build();

            string connectionString =
                configuration.GetConnectionString("DefaultConnection");

            using (ShopContext db = new ShopContext(connectionString))
            {
                db.Database.EnsureCreated();

                FillData(db);

                Console.WriteLine("Початкові дані:");
                ReadData(db);

                EditPhoneById(db, 1);

                Console.WriteLine("\nПісля редагування:");
                ReadData(db);

                DeletePhoneById(db, 2);

                Console.WriteLine("\nПісля видалення:");
                ReadData(db);
            }
        }

        // 1. Заповнення даними через List
        static void FillData(ShopContext db)
        {
            if (!db.Phones.Any())
            {
                List<Phone> phones = new List<Phone>
                {
                    new Phone
                    {
                        Manufacturer = "Apple",
                        Model = "iPhone 15",
                        Year = 2024,
                        Price = 45000
                    },
                    new Phone
                    {
                        Manufacturer = "Samsung",
                        Model = "Galaxy S24",
                        Year = 2024,
                        Price = 40000
                    },
                    new Phone
                    {
                        Manufacturer = "Xiaomi",
                        Model = "Redmi Note 13",
                        Year = 2024,
                        Price = 12000
                    }
                };

                db.Phones.AddRange(phones);
                db.SaveChanges();
            }
        }

        static void ReadData(ShopContext db)
        {
            List<Phone> phones = db.Phones.ToList();

            foreach (Phone phone in phones)
            {
                Console.WriteLine(
                    $"Id: {phone.Id}, " +
                    $"Manufacturer: {phone.Manufacturer}, " +
                    $"Model: {phone.Model}, " +
                    $"Year: {phone.Year}, " +
                    $"Price: {phone.Price}");
            }
        }

        static void DeletePhoneById(ShopContext db, int id)
        {
            Phone phone = db.Phones.Find(id);

            if (phone != null)
            {
                db.Phones.Remove(phone);
                db.SaveChanges();
            }
        }

        static void EditPhoneById(ShopContext db, int id)
        {
            Phone phone = db.Phones.Find(id);

            if (phone != null)
            {
                phone.Manufacturer = "Google";
                phone.Model = "Pixel 9";
                phone.Year = 2025;
                phone.Price = 35000;

                db.SaveChanges();
            }
        }
    }
}
    }
}
